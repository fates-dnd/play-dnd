part of 'character_bloc.dart';

class CharacterState {

  final int level;
  final int strength;
  final int dexterity;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;

  CharacterState({
    this.level = 1,
    this.strength = 10,
    this.dexterity = 10,
    this.constitution = 10,
    this.intelligence = 10,
    this.wisdom = 10,
    this.charisma = 10,
  });

  int get strengthBonus => (strength - 10) ~/ 2;
  int get dexterityBonus => (dexterity - 10) ~/ 2;
  int get constitutionBonus => (constitution - 10) ~/ 2;
  int get intelligenceBonus => (intelligence - 10) ~/ 2;
  int get wisdomBonus => (wisdom - 10) ~/ 2;
  int get charismaBonus => (charisma - 10) ~/ 2;

  int get initiative => dexterityBonus;

  int get proficiencyBonus => calculateProficiencyBonus(level);
}
