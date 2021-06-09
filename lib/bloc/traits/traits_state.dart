part of 'traits_bloc.dart';

@immutable
abstract class TraitsState {}

class TraitsInitial extends TraitsState {}

class TraitsLoaded extends TraitsState {

  final List<Trait> traits;

  TraitsLoaded(this.traits);
}
