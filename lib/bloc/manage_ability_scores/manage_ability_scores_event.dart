part of 'manage_ability_scores_bloc.dart';

class ManageAbilityScoresEvent {
  final Characteristic characteristic;
  final int newValue;

  ManageAbilityScoresEvent(this.characteristic, this.newValue);
}
