import 'package:flutter/services.dart';

Future<String> readRacesJson(String lang) async {
  return rootBundle.loadString("assets/rules/$lang/races.json");
}

Future<String> readTraitsJson(String lang) async {
  return rootBundle.loadString("assets/rules/$lang/traits.json");
}

Future<String> readClassesJson(String lang) async {
  return rootBundle.loadString("assets/rules/$lang/classes.json");
}

Future<String> readSkillsJson(String lang) async {
  return rootBundle.loadString("assets/rules/$lang/skills.json");
}

Future<String> readEquipmentJson(String lang) async {
  return rootBundle.loadString("assets/rules/$lang/equipment.json");
}

Future<String> readSpellsJson(String lang) async {
  return rootBundle.loadString("assets/rules/$lang/spells.json");
}
