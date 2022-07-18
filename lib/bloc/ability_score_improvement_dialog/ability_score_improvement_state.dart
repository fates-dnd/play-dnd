part of 'ability_score_improvement_bloc.dart';

class AbilityScoreImprovementState {
  final Characteristic? option1;
  final Characteristic? option2;

  bool get isPopulated => option1 != null && option2 != null;

  AbilityScoreImprovementState({this.option1, this.option2});
}
