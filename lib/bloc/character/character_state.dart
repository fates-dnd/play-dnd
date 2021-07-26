part of 'character_bloc.dart';

class CharacterState {
  final int level;
  final int strength;
  final int dexterity;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;

  final Race? race;
  final Class? clazz;

  final List<Skill>? skills;

  CharacterState({
    this.level = 1,
    this.strength = 10,
    this.dexterity = 10,
    this.constitution = 10,
    this.intelligence = 10,
    this.wisdom = 10,
    this.charisma = 10,
    this.race,
    this.clazz,
    this.skills,
  });

  int get strengthBonus => (strength - 10) ~/ 2;
  int get dexterityBonus => (dexterity - 10) ~/ 2;
  int get constitutionBonus => (constitution - 10) ~/ 2;
  int get intelligenceBonus => (intelligence - 10) ~/ 2;
  int get wisdomBonus => (wisdom - 10) ~/ 2;
  int get charismaBonus => (charisma - 10) ~/ 2;

  int get strengthSavingThrow =>
      strengthBonus +
      ((clazz?.savingThrows.contains(Characteristic.STRENGTH) ?? false)
          ? proficiencyBonus
          : 0);

  int get dexteritySavingThrow =>
      dexterityBonus +
      ((clazz?.savingThrows.contains(Characteristic.DEXTERITY) ?? false)
          ? proficiencyBonus
          : 0);

  int get constitutionSavingThrow =>
      constitutionBonus +
      ((clazz?.savingThrows.contains(Characteristic.CONSTITUTION) ?? false)
          ? proficiencyBonus
          : 0);

  int get intelligenceSavingThrow =>
      intelligenceBonus +
      ((clazz?.savingThrows.contains(Characteristic.INTELLECT) ?? false)
          ? proficiencyBonus
          : 0);

  int get wisdomSavingThrow =>
      dexterityBonus +
      ((clazz?.savingThrows.contains(Characteristic.WISDOM) ?? false)
          ? proficiencyBonus
          : 0);

  int get charismaSavingThrow =>
      charismaBonus +
      ((clazz?.savingThrows.contains(Characteristic.CHARISMA) ?? false)
          ? proficiencyBonus
          : 0);

  int get initiative => dexterityBonus;

  int get proficiencyBonus => calculateProficiencyBonus(level);

  List<SkillBonus> get skillBonuses => skills
      ?.map((skill) => SkillBonus(
            skill,
            getSkillBonus(skill),
            false,
          ))
      .toList() ?? [];

  int getSkillBonus(Skill skill) {
    switch (skill.characteristic) {
      case Characteristic.STRENGTH:
        return strengthBonus;
      case Characteristic.DEXTERITY:
        return dexterityBonus;
      case Characteristic.CONSTITUTION:
        return constitutionBonus;
      case Characteristic.INTELLECT:
        return intelligenceBonus;
      case Characteristic.WISDOM:
        return wisdomBonus;
      case Characteristic.CHARISMA:
        return charismaBonus;
    }
  }
}
