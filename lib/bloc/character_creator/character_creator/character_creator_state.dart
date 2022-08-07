part of 'character_creator_bloc.dart';

@immutable
class CharacterCreatorState {
  final Race? race;
  final List<Trait>? traits;
  final Class? clazz;
  final List<AbilityBonus>? abilityBonuses;
  final String? name;
  final int? maxHp;
  final int? hp;
  final int? strength;
  final int? dexterity;
  final int? constitution;
  final int? intelligence;
  final int? wisdom;
  final int? charisma;
  final List<Skill>? selectedProficiencies;
  final List<EquipmentQuantity>? selectedEquipment;

  CharacterCreatorState({
    this.race,
    this.traits,
    this.clazz,
    this.abilityBonuses,
    this.name,
    this.maxHp,
    this.hp,
    this.strength,
    this.dexterity,
    this.constitution,
    this.intelligence,
    this.wisdom,
    this.charisma,
    this.selectedProficiencies,
    this.selectedEquipment,
  });

  CharacterCreatorState copyWith({
    Race? race,
    List<Trait>? traits,
    Class? clazz,
    List<AbilityBonus>? bonusCharacteristic,
    String? name,
    int? level,
    int? maxHp,
    int? hp,
    int? strength,
    int? dexterity,
    int? constitution,
    int? intelligence,
    int? wisdom,
    int? charisma,
    List<Skill>? selectedProficiencies,
    List<EquipmentQuantity>? selectedEquipment,
  }) {
    return CharacterCreatorState(
      race: race ?? this.race,
      traits: traits ?? this.traits,
      clazz: clazz ?? this.clazz,
      abilityBonuses: bonusCharacteristic ?? this.abilityBonuses,
      name: name ?? this.name,
      maxHp: maxHp ?? this.maxHp,
      hp: hp ?? this.hp,
      strength: strength ?? this.strength,
      dexterity: dexterity ?? this.dexterity,
      constitution: constitution ?? this.constitution,
      intelligence: intelligence ?? this.intelligence,
      wisdom: wisdom ?? this.wisdom,
      charisma: charisma ?? this.charisma,
      selectedProficiencies:
          selectedProficiencies ?? this.selectedProficiencies,
      selectedEquipment: selectedEquipment ?? this.selectedEquipment,
    );
  }

  Character? toCharacter() {
    return Character(
      name!,
      1, // level
      maxHp!,
      hp!,
      strength!,
      dexterity!,
      constitution!,
      intelligence!,
      wisdom!,
      charisma!,
      race!,
      clazz!,
      selectedProficiencies!,
      selectedEquipment!,
    );
  }
}
