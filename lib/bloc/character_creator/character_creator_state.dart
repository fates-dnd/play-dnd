part of 'character_creator_bloc.dart';

@immutable
class CharacterCreatorState {
  final Race? race;
  final List<Trait>? traits;
  final Class? clazz;

  CharacterCreatorState({this.race, this.traits, this.clazz});
}
