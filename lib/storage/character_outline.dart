import 'package:dnd_player_flutter/dto/character.dart';

class CharacterOutline {
  final String name;
  final int level;
  final int maxHp;
  final int hp;
  final int baseStrength;
  final int baseDexterity;
  final int baseConstitution;
  final int baseIntelligence;
  final int baseWisdom;
  final int baseCharisma;

  final String raceIndex;
  final String classIndex;
  final List<String> proficiencyIndexes;

  final List<EquipmentIndexQuantity> allEquipment;

  final List<String> preparedSpells;
  final List<String> learnedSpells;

  final Map<int, int> usedSpellSlots;
  final Map<int, int> money;

  CharacterOutline(
    this.name,
    this.level,
    this.maxHp,
    this.hp,
    this.baseStrength,
    this.baseDexterity,
    this.baseConstitution,
    this.baseIntelligence,
    this.baseWisdom,
    this.baseCharisma,
    this.raceIndex,
    this.classIndex,
    this.proficiencyIndexes,
    this.allEquipment,
    this.preparedSpells,
    this.learnedSpells,
    this.usedSpellSlots,
    this.money,
  );

  static CharacterOutline fromCharacter(
    Character character, {
    required List<EquipmentIndexQuantity> equipment,
    required List<EquipmentIndexQuantity> equippedItems,
    required List<String> preparedSpells,
    required List<String> learnedSpells,
    required Map<int, int> usedSpellSlots,
    required Map<int, int> money,
  }) {
    return CharacterOutline(
      character.name,
      character.level,
      character.maxHp,
      character.hp,
      character.baseStrength,
      character.baseDexterity,
      character.baseConstitution,
      character.baseIntelligence,
      character.baseWisdom,
      character.baseCharisma,
      character.race.index,
      character.clazz.index,
      character.selectedProficiencies.map((skill) => skill.index).toList(),
      equipment,
      preparedSpells,
      learnedSpells,
      usedSpellSlots,
      money,
    );
  }

  CharacterOutline copyWith({
    String? name,
    int? level,
    int? maxHp,
    int? hp,
    int? baseStrength,
    int? baseDexterity,
    int? baseConstitution,
    int? baseIntelligence,
    int? baseWisdom,
    int? baseCharisma,
    String? raceIndex,
    String? classIndex,
    List<String>? proficiencyIndexes,
    List<EquipmentIndexQuantity>? allEquipmentIndexes,
    List<String>? preparedSpells,
    List<String>? learnedSpells,
    Map<int, int>? usedSpellSlots,
    Map<int, int>? money,
  }) {
    return CharacterOutline(
      name ?? this.name,
      level ?? this.level,
      maxHp ?? this.maxHp,
      hp ?? this.hp,
      baseStrength ?? this.baseStrength,
      baseDexterity ?? this.baseDexterity,
      baseConstitution ?? this.baseConstitution,
      baseIntelligence ?? this.baseIntelligence,
      baseWisdom ?? this.baseWisdom,
      baseCharisma ?? this.baseCharisma,
      raceIndex ?? this.raceIndex,
      classIndex ?? this.classIndex,
      proficiencyIndexes ?? this.proficiencyIndexes,
      allEquipmentIndexes ?? this.allEquipment,
      preparedSpells ?? this.preparedSpells,
      learnedSpells ?? this.learnedSpells,
      usedSpellSlots ?? this.usedSpellSlots,
      money ?? this.money,
    );
  }
}

class EquipmentIndexQuantity {
  final String index;
  final int quantity;
  final bool isEquipped;

  EquipmentIndexQuantity(this.index, this.quantity, this.isEquipped);
}
