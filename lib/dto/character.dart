import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/race.dart';

class Character {

  final String name;
  final Race race;
  final Class clazz;

  Character(this.name, this.race, this.clazz);
}
