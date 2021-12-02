import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/race.dart';

class Character {
  final String name;
  final int level;
  final int baseStrength;
  final int baseDexterity;
  final int baseConstitution;
  final int baseIntelligence;
  final int baseWisdom;
  final int baseCharisma;

  final Race race;
  final Class clazz;

  Character(
      this.name,
      this.level,
      this.baseStrength,
      this.baseDexterity,
      this.baseConstitution,
      this.baseIntelligence,
      this.baseWisdom,
      this.baseCharisma,
      this.race,
      this.clazz);
}
