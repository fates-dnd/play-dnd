import 'package:dnd_player_flutter/dto/rest.dart';
import 'package:dnd_player_flutter/dto/user_feature.dart';
import 'package:dnd_player_flutter/storage/character_outline.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int DB_VERSION = 100;

Future<bool> shouldClearBox() async {
  final prefs = await SharedPreferences.getInstance();
  final version = prefs.getInt("DB_VERSION");

  prefs.setInt("DB_VERSION", DB_VERSION);

  return DB_VERSION > (version ?? 0);
}

void setupTypeAdapters() {
  Hive.registerAdapter<CharacterOutline?>(CharacterOutlineAdapter());
  Hive.registerAdapter<EquipmentIndexQuantity?>(
      EquipmentIndexQuantityAdapter());
  Hive.registerAdapter<UserFeature>(UserFeatureAdapter());
  Hive.registerAdapter<Usage>(UsageAdapter());
  Hive.registerAdapter<Rest>(RestAdapter());
}
