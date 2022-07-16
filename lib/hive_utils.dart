import 'package:dnd_player_flutter/dto/rest.dart';
import 'package:dnd_player_flutter/dto/user_feature.dart';
import 'package:dnd_player_flutter/storage/character_outline.dart';
import 'package:hive/hive.dart';

void setupTypeAdapters() {
  Hive.registerAdapter<CharacterOutline?>(CharacterOutlineAdapter());
  Hive.registerAdapter<EquipmentIndexQuantity?>(
      EquipmentIndexQuantityAdapter());
  Hive.registerAdapter<UserFeature>(UserFeatureAdapter());
  Hive.registerAdapter<Usage>(UsageAdapter());
  Hive.registerAdapter<Rest>(RestAdapter());
}
