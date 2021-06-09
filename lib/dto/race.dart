class Race {
  final String index;
  final String name;
  final String description;
  final int baseSpeed;
  final String abilityBonusDescription;
  final List<AbilityBonus> abilityBonuses;
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
      this.age,
      this.alignment,
      this.size,
      this.sizeDescription,
      this.languagesDescription);
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

enum Size { SMALL, MEDIUM, LARGE }
