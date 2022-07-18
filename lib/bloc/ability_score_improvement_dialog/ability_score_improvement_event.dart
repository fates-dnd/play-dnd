part of 'ability_score_improvement_bloc.dart';

abstract class AbilityScoreImprovementEvent {}

class SetImprovementOption1 extends AbilityScoreImprovementEvent {
  final Characteristic? characteristic;

  SetImprovementOption1(this.characteristic);
}

class SetImprovementOption2 extends AbilityScoreImprovementEvent {
  final Characteristic? characteristic;

  SetImprovementOption2(this.characteristic);
}
