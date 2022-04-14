import 'package:dnd_player_flutter/dto/class.dart';

class Feature {
  final String index;
  final Class clazz;
  final String name;
  final int? level;
  final Map<String, int>? levels;
  final bool? expandable;
  final List<String> description;
  final String? parent;

  Feature(
    this.index,
    this.clazz,
    this.name,
    this.level,
    this.levels,
    this.expandable,
    this.description,
    this.parent,
  );

  int? getNonExpandableItemSize(int level) {
    if (levels != null && expandable == false) {
      return levels![levels!.keys.lastWhere((key) => int.parse(key) <= level)];
    }
    return null;
  }
}
