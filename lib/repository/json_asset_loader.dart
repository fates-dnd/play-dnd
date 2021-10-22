import 'package:flutter/services.dart';

Future<String> readRacesJson() async {
  return rootBundle.loadString("assets/races.json");
}

Future<String> readTraitsJson() async {
  return rootBundle.loadString("assets/traits.json");
}

Future<String> readClassesJson() async {
  return rootBundle.loadString("assets/classes.json");
}

Future<String> readSkillsJson() async {
  return rootBundle.loadString("assets/skills.json");
}

Future<String> readEquipmentJson() async {
  return rootBundle.loadString("assets/equipment.json");
}

Future<String> readSpellsJson() async {
  return rootBundle.loadString("assets/spells.json");
}
