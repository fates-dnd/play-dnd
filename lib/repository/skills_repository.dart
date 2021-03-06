import 'dart:convert';

import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/skill.dart';

class SkillsRepository {
  final Future<String> Function(String lang) jsonReader;

  List<Skill>? skills;
  String? language;

  SkillsRepository(this.jsonReader);

  Future<List<Skill>> getSkills(String language) async {
    if (skills != null && this.language == language) {
      return skills!;
    }
    final response = await jsonReader(language);
    final List<dynamic> skillsJson = json.decode(response);
    skills = skillsJson.map((skillJson) => _fromJson(skillJson)).toList();
    return skills!;
  }

  void resetWithLanguage(String language) {
    this.language = language;
  }

  Future<List<Skill>> findByIndexes(
      String language, List<String> indexes) async {
    final skills = await getSkills(language);
    return indexes
        .map((index) => skills.firstWhere((element) => element.index == index))
        .toList();
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
        return Characteristic.INTELLIGENCE;
      case "wis":
        return Characteristic.WISDOM;
      case "cha":
        return Characteristic.CHARISMA;
      default:
        throw ArgumentError("No characteristic for index $index");
    }
  }
}
