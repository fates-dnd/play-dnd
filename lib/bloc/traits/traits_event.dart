part of 'traits_bloc.dart';

@immutable
abstract class TraitsEvent {}

class LoadTraitsForRace extends TraitsEvent {

  final String raceIndex;

  LoadTraitsForRace(this.raceIndex);
}
