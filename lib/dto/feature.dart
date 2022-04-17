import 'package:dnd_player_flutter/dto/class.dart';

class Feature {
  final String index;
  final Class clazz;
  final String name;
  final int? level;
  final Map<String, int>? levels;
  final Map<String, String>? levelNames;
  final bool? expandable;
  final List<String> description;
  final String? parent;

  Feature(
    this.index,
    this.clazz,
    this.name,
    this.level,
    this.levels,
    this.levelNames,
    this.expandable,
    this.description,
    this.parent,
  );

  String? getNonExpandableNameForLevel(int level) {
    if (levelNames != null && expandable == false) {
      return levelNames![
          levelNames!.keys.lastWhere((key) => int.parse(key) <= level)];
    }
    return null;
  }
}
