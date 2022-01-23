import 'dart:io';

import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/features_repository.dart';
import 'package:dnd_player_flutter/repository/levels_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';

Future<ClassesRepository> createClassesRepository() async {
  final SkillsRepository skillsRepository = SkillsRepository((language) async {
    return await File("assets/rules/$language/skills.json").readAsString();
  });

  final EquipmentRepository equipmentRepository =
      EquipmentRepository((language) async {
    return File("assets/rules/$language/equipment.json").readAsStringSync();
  });

  return ClassesRepository(skillsRepository, equipmentRepository,
      (language) async {
    final classesFile = File("assets/rules/$language/classes.json");
    return classesFile.readAsStringSync();
  });
}

Future<FeaturesRepository> createFeaturesRepository() async {
  return FeaturesRepository((language) async {
    final featuresFile = File("assets/rules/$language/features.json");
    return featuresFile.readAsStringSync();
  }, await createClassesRepository());
}

Future<LevelsRepository> createLevelsRepository() async {
  return LevelsRepository((language) async {
    final file = File("assets/rules/$language/levels.json");
    return file.readAsStringSync();
  }, await createFeaturesRepository(), await createClassesRepository());
}
