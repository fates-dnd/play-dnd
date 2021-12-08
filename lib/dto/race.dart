import 'package:equatable/equatable.dart';

class Race extends Equatable {
  final String index;
  final String name;
  final String description;
  final int baseSpeed;
  final String abilityBonusDescription;
  final List<AbilityBonus> abilityBonuses;
  final AbilityBonusOptions? abilityBonusOptions;
  final String age;
  final String alignment;
  final Size size;
  final String sizeDescription;
  final String languagesDescription;

  Race(
      this.index,
      this.name,
      this.description,
      this.baseSpeed,
      this.abilityBonusDescription,
      this.abilityBonuses,
      this.abilityBonusOptions,
      this.age,
      this.alignment,
      this.size,
      this.sizeDescription,
      this.languagesDescription);

  @override
  List<Object?> get props => [index, name];
}

class AbilityBonus {
  final AbilityScore abilityScore;
  final int bonus;

  AbilityBonus(this.abilityScore, this.bonus);
}

class AbilityScore {
  final String index;
  final String name;

  AbilityScore(this.index, this.name);
}

class AbilityBonusOptions {
  final int choose;
  final List<AbilityBonus> abilityBonuses;

  AbilityBonusOptions(this.choose, this.abilityBonuses);
}

enum Size { SMALL, MEDIUM, LARGE }
