import 'package:dnd_player_flutter/dto/character.dart';

class CharacterOutline {
  final String name;
  final int level;
  final int baseStrength;
  final int baseDexterity;
  final int baseConstitution;
  final int baseIntelligence;
  final int baseWisdom;
  final int baseCharisma;

  final String classIndex;
  final String raceIndex;
  final List<String> equipmentIndexes;

  CharacterOutline(
    this.name,
    this.level,
    this.baseStrength,
    this.baseDexterity,
    this.baseConstitution,
    this.baseIntelligence,
    this.baseWisdom,
    this.baseCharisma,
    this.classIndex,
    this.raceIndex,
    this.equipmentIndexes,
  );

  static CharacterOutline fromCharacter(Character character) {
    return CharacterOutline(
      character.name,
      character.level,
      character.baseStrength,
      character.baseDexterity,
      character.baseConstitution,
      character.baseIntelligence,
      character.baseWisdom,
      character.baseCharisma,

      character.race.index,
      character.clazz.index,

      [] // equipment
    );
  }
}
