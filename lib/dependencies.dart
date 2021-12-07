import 'dart:io';

import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/json_asset_loader.dart';
import 'package:dnd_player_flutter/repository/races_repository.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:dnd_player_flutter/repository/traits_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void registerDependencies() {
  var defaultLocale = "en";

  try {
    defaultLocale = Platform.localeName.substring(0, 2);
  } catch (e) {}

  getIt
      .registerSingleton<SettingsRepository>(SettingsRepository(defaultLocale));
  getIt.registerSingleton<RacesRepository>(RacesRepository(readRacesJson));
  getIt.registerSingleton<TraitsRepository>(TraitsRepository(readTraitsJson));
  getIt.registerSingleton<SkillsRepository>(SkillsRepository(readSkillsJson));
  getIt.registerSingleton<EquipmentRepository>(
      EquipmentRepository(readEquipmentJson));
  getIt.registerSingleton<ClassesRepository>(ClassesRepository(
    getIt.get<SkillsRepository>(),
    getIt.get<EquipmentRepository>(),
    readClassesJson,
  ));
  getIt.registerSingleton<CharacterRepository>(CharacterRepository(
    getIt.get<SettingsRepository>(),
    getIt.get<RacesRepository>(),
    getIt.get<ClassesRepository>(),
    getIt.get<SkillsRepository>(),
    getIt.get<EquipmentRepository>(),
  ));
  getIt.registerSingleton<SpellsRepository>(SpellsRepository(readSpellsJson));
}
