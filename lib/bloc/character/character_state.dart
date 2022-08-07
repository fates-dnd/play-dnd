part of 'character_bloc.dart';

class CharacterState {
  final String name;
  final int level;
  final int maxHp;
  final int hp;

  final int strength;
  final int dexterity;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;

  final Race? race;
  final Class? clazz;

  final List<Skill>? skills;
  final List<Skill>? proficienctSkills;

  final List<EquipmentQuantity>? equipment;

  final List<Spell>? preparedSpells;
  final List<Spell>? learnedSpells;

  final Map<int, SpellSlots>? levelSpellSlots;
  final Map<Currency, int>? money;

  final List<Trait>? traits;
  final List<UserFeature>? userFeatures;

  CharacterState({
    this.name = "",
    this.level = 1,
    this.maxHp = 0,
    this.hp = 0,
    this.strength = 10,
    this.dexterity = 10,
    this.constitution = 10,
    this.intelligence = 10,
    this.wisdom = 10,
    this.charisma = 10,
    this.race,
    this.clazz,
    this.skills,
    this.proficienctSkills,
    this.equipment,
    this.preparedSpells,
    this.learnedSpells,
    this.levelSpellSlots,
    this.money,
    this.traits,
    this.userFeatures,
  });

  CharacterState copyWith({
    int? level,
    int? hp,
    int? maxHp,
    int? strength,
    int? dexterity,
    int? constitution,
    int? intelligence,
    int? wisdom,
    int? charisma,
    Race? race,
    Class? clazz,
    List<Skill>? skills,
    List<Skill>? proficienctSkills,
    List<EquipmentQuantity>? equipment,
    List<Spell>? preparedSpells,
    List<Spell>? learnedSpells,
    Map<int, SpellSlots>? levelSpellSlots,
    Map<Currency, int>? money,
    Map<Feature, int>? featureUsage,
    List<UserFeature>? userFeatures,
  }) {
    return CharacterState(
      name: name,
      level: level ?? this.level,
      hp: hp ?? this.hp,
      maxHp: maxHp ?? this.maxHp,
      strength: strength ?? this.strength,
      dexterity: dexterity ?? this.dexterity,
      constitution: constitution ?? this.constitution,
      intelligence: intelligence ?? this.intelligence,
      wisdom: wisdom ?? this.wisdom,
      charisma: charisma ?? this.charisma,
      race: race ?? this.race,
      clazz: clazz ?? this.clazz,
      skills: skills ?? this.skills,
      proficienctSkills: proficienctSkills ?? this.proficienctSkills,
      equipment: equipment ?? this.equipment,
      preparedSpells: preparedSpells ?? this.preparedSpells,
      levelSpellSlots: levelSpellSlots ?? this.levelSpellSlots,
      money: money ?? this.money,
      traits: traits,
      userFeatures: userFeatures ?? this.userFeatures,
    );
  }

  int get totalStrength =>
      strength + _getRaceAbilityBonus(Characteristic.STRENGTH);
  int get totalDexterity =>
      dexterity + _getRaceAbilityBonus(Characteristic.DEXTERITY);
  int get totalConstitution =>
      constitution + _getRaceAbilityBonus(Characteristic.CONSTITUTION);
  int get totalIntelligence =>
      intelligence + _getRaceAbilityBonus(Characteristic.INTELLIGENCE);
  int get totalWisdom => wisdom + _getRaceAbilityBonus(Characteristic.WISDOM);
  int get totalCharisma =>
      charisma + _getRaceAbilityBonus(Characteristic.CHARISMA);

  int get strengthBonus => totalStrength.toModifier();
  int get dexterityBonus => totalDexterity.toModifier();
  int get constitutionBonus => totalConstitution.toModifier();
  int get intelligenceBonus => totalIntelligence.toModifier();
  int get wisdomBonus => totalWisdom.toModifier();
  int get charismaBonus => totalCharisma.toModifier();

  int get strengthSavingThrow =>
      strengthBonus +
      ((clazz?.savingThrows.contains(Characteristic.STRENGTH) ?? false)
          ? proficiencyBonus
          : 0);

  int get dexteritySavingThrow =>
      dexterityBonus +
      ((clazz?.savingThrows.contains(Characteristic.DEXTERITY) ?? false)
          ? proficiencyBonus
          : 0);

  int get constitutionSavingThrow =>
      constitutionBonus +
      ((clazz?.savingThrows.contains(Characteristic.CONSTITUTION) ?? false)
          ? proficiencyBonus
          : 0);

  int get intelligenceSavingThrow =>
      intelligenceBonus +
      ((clazz?.savingThrows.contains(Characteristic.INTELLIGENCE) ?? false)
          ? proficiencyBonus
          : 0);

  int get wisdomSavingThrow =>
      dexterityBonus +
      ((clazz?.savingThrows.contains(Characteristic.WISDOM) ?? false)
          ? proficiencyBonus
          : 0);

  int get charismaSavingThrow =>
      charismaBonus +
      ((clazz?.savingThrows.contains(Characteristic.CHARISMA) ?? false)
          ? proficiencyBonus
          : 0);

  int get initiative => dexterityBonus;

  int get proficiencyBonus => calculateProficiencyBonus(level);

  bool get isASpellcaster => clazz?.spellcastingAbility != null;

  List<EquipmentQuantity>? get equippedItems =>
      equipment?.where((element) => element.isEquipped).toList();

  int get armorClass {
    final armorBonus = equippedItems?.fold<int>(0, (previousValue, element) {
      final armorCategory = element.equipment.armorCategory;
      final armorClass = element.equipment.armorClass;
      if (armorCategory != null) {
        return previousValue +
            (armorClass?.base ?? 0) +
            ((armorClass?.dexBonus == true) ? dexterityBonus : 0);
      }
      return 0;
    });

    if (armorBonus != null && armorBonus > 0) {
      return armorBonus;
    }

    return 10 + dexterityBonus;
  }

  UnarmedAttack get unarmedAttack => UnarmedAttack(
        attackBonus: strengthBonus + proficiencyBonus,
        damage: strengthBonus,
      );

  List<SkillBonus> get skillBonuses =>
      skills?.map((skill) {
        final isProficient = proficienctSkills?.contains(skill) ?? false;
        final bonus = getCharacteristicBonus(skill.characteristic) +
            (isProficient ? proficiencyBonus : 0);
        return SkillBonus(
          skill,
          bonus,
          isProficient,
        );
      }).toList() ??
      [];

  int? get spellcastingModifier => clazz?.spellcastingAbility != null
      ? getCharacteristicBonus(clazz!.spellcastingAbility!)
      : null;

  int? get spellcastingAttack => (spellcastingModifier ?? 0) + proficiencyBonus;

  int? get spellSavingThrow =>
      8 + (spellcastingModifier ?? 0) + proficiencyBonus;

  bool get hasMoney => money?.values.any((element) => element != 0) ?? false;

  Map<int, List<Spell>>? get groupedSpells =>
      preparedSpells?.fold(<int, List<Spell>>{}, (previousValue, element) {
        var list = previousValue![element.level];
        if (list == null) {
          list = <Spell>[];
          previousValue[element.level] = list;
        }
        list.add(element);
        return previousValue;
      });

  int getCharacteristicBonus(Characteristic characteristic) {
    switch (characteristic) {
      case Characteristic.STRENGTH:
        return strengthBonus;
      case Characteristic.DEXTERITY:
        return dexterityBonus;
      case Characteristic.CONSTITUTION:
        return constitutionBonus;
      case Characteristic.INTELLIGENCE:
        return intelligenceBonus;
      case Characteristic.WISDOM:
        return wisdomBonus;
      case Characteristic.CHARISMA:
        return charismaBonus;
    }
  }

  int getAttackBonus(Equipment equipment) {
    final isDexBased = _isDexBased(equipment);
    final isProficient =
        (clazz?.equipmentProficiencies ?? []).any((proficiency) {
      return proficiency["index"] == equipment.index ||
          proficiency["weapon_category"] == equipment.weaponCategory;
    });
    if (isDexBased) {
      return dexterityBonus + (isProficient ? proficiencyBonus : 0);
    }
    return strengthBonus + (isProficient ? proficiencyBonus : 0);
  }

  int getDamageBonus(Equipment equipment) {
    return _isDexBased(equipment) ? dexterityBonus : strengthBonus;
  }

  bool _isDexBased(Equipment equipment) {
    return equipment.weaponRange == WeaponRange.RANGED ||
        (equipment.properties ?? []).any((element) =>
            element == Property.FINESSE || element == Property.THROWN);
  }

  int _getRaceAbilityBonus(Characteristic characteristic) {
    return race?.abilityBonuses
            .firstWhereOrNull(
                (element) => element.characteristic == characteristic)
            ?.bonus ??
        0;
  }
}
