part of 'character_creator_bloc.dart';

@immutable
abstract class CharacterCreatorEvent {}

class SubmitRace extends CharacterCreatorEvent {
  final Race race;
  final List<Trait> traits;

  SubmitRace(this.race, this.traits);
}

class SubmitClass extends CharacterCreatorEvent {
  final Class clazz;

  SubmitClass(this.clazz);
}

class SubmitBonusCharacteristics extends CharacterCreatorEvent {
  final List<CharacteristicBonus>? bonusCharacteristics;

  SubmitBonusCharacteristics(this.bonusCharacteristics);
}

class SubmitCharacteristics extends CharacterCreatorEvent {
  final String? name;
  final int? level;
  final int? strength;
  final int? dexterity;
  final int? constitution;
  final int? intelligence;
  final int? wisdom;
  final int? charisma;

  SubmitCharacteristics(
    this.name,
    this.level,
    this.strength,
    this.dexterity,
    this.constitution,
    this.intelligence,
    this.wisdom,
    this.charisma,
  );
}
