import 'dart:io';

import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/features_repository.dart';
import 'package:dnd_player_flutter/repository/levels_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:dnd_player_flutter/repository/traits_repository.dart';

SkillsRepository? skillsRepository;
EquipmentRepository? equipmentRepository;
ClassesRepository? classesRepository;
TraitsRepository? traitsRepository;
FeaturesRepository? featuresRepository;
LevelsRepository? levelsRepository;

Future<SkillsRepository> createSkillsRepository() async {
  if (skillsRepository == null) {
    skillsRepository = SkillsRepository((language) async {
      return File("assets/rules/$language/skills.json").readAsStringSync();
    });
  }
  return skillsRepository!;
}

Future<EquipmentRepository> createEquipmentRepository() async {
  if (equipmentRepository == null) {
    equipmentRepository = EquipmentRepository((language) async {
      return File("assets/rules/$language/equipment.json").readAsStringSync();
    });
  }

  return equipmentRepository!;
}

Future<ClassesRepository> createClassesRepository() async {
  if (classesRepository == null) {
    classesRepository = ClassesRepository(
        await createSkillsRepository(), await createEquipmentRepository(),
        (language) async {
      return File("assets/rules/$language/classes.json").readAsStringSync();
    });
  }
  return classesRepository!;
}

Future<TraitsRepository> createTraitsRepository() async {
  if (traitsRepository == null) {
    traitsRepository = TraitsRepository((language) async {
      return File("assets/rules/$language/traits.json").readAsStringSync();
    });
  }
  return traitsRepository!;
}

Future<FeaturesRepository> createFeaturesRepository() async {
  if (featuresRepository == null) {
    featuresRepository = FeaturesRepository((language) async {
      return File("assets/rules/$language/features.json").readAsStringSync();
    }, await createClassesRepository());
  }
  return featuresRepository!;
}

Future<LevelsRepository> createLevelsRepository() async {
  if (levelsRepository == null) {
    levelsRepository = LevelsRepository((language) async {
      return File("assets/rules/$language/levels.json").readAsStringSync();
    });
  }
  return levelsRepository!;
}
