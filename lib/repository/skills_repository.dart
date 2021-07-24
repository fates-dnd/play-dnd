import 'dart:convert';

import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/skill.dart';

class SkillsRepository {
  final Future<String> Function() jsonReader;

  SkillsRepository(this.jsonReader);

  Future<List<Skill>> getSkills() async {
    final response = await jsonReader();
    final List<dynamic> skillsJson = json.decode(response);
    return skillsJson.map((skillJson) => _fromJson(skillJson)).toList();
  }

  Skill _fromJson(Map<String, dynamic> json) {
    return Skill(
      json["index"] as String,
      json["name"] as String,
      _characteristicFromIndex(json["ability_score"]["index"]),
    );
  }

  Characteristic _characteristicFromIndex(String index) {
    switch (index) {
      case "str":
        return Characteristic.STRENGTH;
      case "dex":
        return Characteristic.DEXTERITY;
      case "con":
        return Characteristic.CONSTITUTION;
      case "int":
        return Characteristic.INTELLECT;
      case "wis":
        return Characteristic.WISDOM;
      case "cha":
        return Characteristic.CHARISMA;
      default:
        throw ArgumentError("No characteristic for index $index");
    }
  }
}
