part of 'manage_ability_scores_bloc.dart';

class ManageAbilityScoresState {
  final int? newStrengthValue;
  final int? newDexterityValue;
  final int? newConstitutionValue;
  final int? newIntelligenceValue;
  final int? newWisdomValue;
  final int? newCharismaValue;

  ManageAbilityScoresState({
    this.newStrengthValue,
    this.newDexterityValue,
    this.newConstitutionValue,
    this.newIntelligenceValue,
    this.newWisdomValue,
    this.newCharismaValue,
  });

  ManageAbilityScoresState copyWithStregth(int? newStrength) {
    return ManageAbilityScoresState(
      newStrengthValue: newStrength,
      newDexterityValue: newDexterityValue,
      newConstitutionValue: newConstitutionValue,
      newIntelligenceValue: newIntelligenceValue,
      newWisdomValue: newWisdomValue,
      newCharismaValue: newCharismaValue,
    );
  }

  ManageAbilityScoresState copyWithDexterity(int? newDexterity) {
    return ManageAbilityScoresState(
      newStrengthValue: newStrengthValue,
      newDexterityValue: newDexterity,
      newConstitutionValue: newConstitutionValue,
      newIntelligenceValue: newIntelligenceValue,
      newWisdomValue: newWisdomValue,
      newCharismaValue: newCharismaValue,
    );
  }

  ManageAbilityScoresState copyWithConstitution(int? newConstitution) {
    return ManageAbilityScoresState(
      newStrengthValue: newStrengthValue,
      newDexterityValue: newDexterityValue,
      newConstitutionValue: newConstitution,
      newIntelligenceValue: newIntelligenceValue,
      newWisdomValue: newWisdomValue,
      newCharismaValue: newCharismaValue,
    );
  }

  ManageAbilityScoresState copyWithIntelligence(int? newIntelligence) {
    return ManageAbilityScoresState(
      newStrengthValue: newStrengthValue,
      newDexterityValue: newDexterityValue,
      newConstitutionValue: newConstitutionValue,
      newIntelligenceValue: newIntelligence,
      newWisdomValue: newWisdomValue,
      newCharismaValue: newCharismaValue,
    );
  }

  ManageAbilityScoresState copyWithWisdom(int? newWisdom) {
    return ManageAbilityScoresState(
      newStrengthValue: newStrengthValue,
      newDexterityValue: newDexterityValue,
      newConstitutionValue: newConstitutionValue,
      newIntelligenceValue: newIntelligenceValue,
      newWisdomValue: newWisdom,
      newCharismaValue: newCharismaValue,
    );
  }

  ManageAbilityScoresState copyWithCharisma(int? newCharisma) {
    return ManageAbilityScoresState(
      newStrengthValue: newStrengthValue,
      newDexterityValue: newDexterityValue,
      newConstitutionValue: newConstitutionValue,
      newIntelligenceValue: newIntelligenceValue,
      newWisdomValue: newWisdomValue,
      newCharismaValue: newCharisma,
    );
  }
}
