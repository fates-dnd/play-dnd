part of 'set_characteristics_bloc.dart';

@immutable
abstract class SetCharacteristicsEvent {}

class SubmitLevel extends SetCharacteristicsEvent {
  final int level;

  SubmitLevel(this.level);
}

class SubmitCharacteristicsScore extends SetCharacteristicsEvent {
  final Characteristic characteristic;
  final int? score;

  SubmitCharacteristicsScore(this.characteristic, this.score);
}
