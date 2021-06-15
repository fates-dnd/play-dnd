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
