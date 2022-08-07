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
  final List<AbilityBonus>? bonusCharacteristics;

  SubmitBonusCharacteristics(this.bonusCharacteristics);
}

class SubmitCharacteristics extends CharacterCreatorEvent {
  final String? name;
  final int? strength;
  final int? dexterity;
  final int? constitution;
  final int? intelligence;
  final int? wisdom;
  final int? charisma;

  SubmitCharacteristics(
    this.name,
    this.strength,
    this.dexterity,
    this.constitution,
    this.intelligence,
    this.wisdom,
    this.charisma,
  );
}

class SubmitSelectedProficiencies extends CharacterCreatorEvent {
  final List<Skill> proficiencies;

  SubmitSelectedProficiencies(this.proficiencies);
}

class SaveCharacter extends CharacterCreatorEvent {}
