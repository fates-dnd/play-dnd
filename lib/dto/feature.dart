import 'package:dnd_player_flutter/dto/class.dart';

class Feature {
  final String index;
  final Class clazz;
  final String name;
  final int level;
  final List<String> description;

  Feature(
    this.index,
    this.clazz,
    this.name,
    this.level,
    this.description,
  );
}
