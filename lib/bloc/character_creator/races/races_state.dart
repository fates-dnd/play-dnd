part of 'races_bloc.dart';

@immutable
abstract class RacesState {}

class RacesEmpty extends RacesState {}

class RacesLoaded extends RacesState {

  final Map<Race, List<Trait>> racesWithTraits;

  RacesLoaded(this.racesWithTraits);
}
