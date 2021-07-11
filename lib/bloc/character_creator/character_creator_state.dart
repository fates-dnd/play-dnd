part of 'character_creator_bloc.dart';

@immutable
class CharacterCreatorState {
  final Race? race;
  final List<Trait>? traits;
  final Class? clazz;
  final List<CharacteristicBonus>? bonusCharacteristic;
  final String? name;
  final int? level;
  final int? strength;
  final int? dexterity;
  final int? constitution;
  final int? intelligence;
  final int? wisdom;
  final int? charisma;

  CharacterCreatorState({
    this.race,
    this.traits,
    this.clazz,
    this.bonusCharacteristic,
    this.name,
    this.level,
    this.strength,
    this.dexterity,
    this.constitution,
    this.intelligence,
    this.wisdom,
    this.charisma,
  });

  CharacterCreatorState copyWith({
    Race? race,
    List<Trait>? traits,
    Class? clazz,
    List<CharacteristicBonus>? bonusCharacteristic,
    String? name,
    int? level,
    int? strength,
    int? dexterity,
    int? constitution,
    int? intelligence,
    int? wisdom,
    int? charisma,
  }) {
    return CharacterCreatorState(
      race: race ?? this.race,
      traits: traits ?? this.traits,
      clazz: clazz ?? this.clazz,
      bonusCharacteristic: bonusCharacteristic ?? this.bonusCharacteristic,
      name: name ?? this.name,
      level: level ?? this.level,
      strength: strength ?? this.strength,
      dexterity: dexterity ?? this.dexterity,
      constitution: constitution ?? this.constitution,
      intelligence: intelligence ?? this.intelligence,
      wisdom: wisdom ?? this.wisdom,
      charisma: charisma ?? this.charisma,
    );
  }

  Character? toCharacter() {
    return Character(
      name!,
      level!,
      strength!,
      dexterity!,
      constitution!,
      intelligence!,
      wisdom!,
      charisma!,

      race!,
      clazz!,
    );
  }
}
