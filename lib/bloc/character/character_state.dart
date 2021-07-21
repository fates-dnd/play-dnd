part of 'character_bloc.dart';

class CharacterState {

  final int strength;
  final int dexterity;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;

  CharacterState({
    this.strength = 0,
    this.dexterity = 0,
    this.constitution = 0,
    this.intelligence = 0,
    this.wisdom = 0,
    this.charisma = 0,
  });

  int get strengthBonus => (strength - 10) ~/ 2;
  int get dexterityBonus => (dexterity - 10) ~/ 2;
  int get constitutionBonus => (constitution - 10) ~/ 2;
  int get intelligenceBonus => (intelligence - 10) ~/ 2;
  int get wisdomBonus => (wisdom - 10) ~/ 2;
  int get charismaBonus => (charisma - 10) ~/ 2;
}
