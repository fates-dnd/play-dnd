part of 'set_characteristics_bloc.dart';

@immutable
abstract class SetCharacteristicsEvent {}

class SubmitName extends SetCharacteristicsEvent {
  final String name;

  SubmitName(this.name);
}

class SubmitCharacteristicsScore extends SetCharacteristicsEvent {
  final Characteristic characteristic;
  final int? score;

  SubmitCharacteristicsScore(this.characteristic, this.score);
}
