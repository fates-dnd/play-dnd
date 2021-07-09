import 'package:dnd_player_flutter/storage/ability_bonus_type_adapter.dart';
import 'package:dnd_player_flutter/storage/ability_score_type_adapter.dart';
import 'package:dnd_player_flutter/storage/character_type_adapter.dart';
import 'package:dnd_player_flutter/storage/class_type_adapter.dart';
import 'package:dnd_player_flutter/storage/size_type_adapter.dart';
import 'package:hive/hive.dart';

import 'dto/character.dart';
import 'dto/class.dart';
import 'dto/race.dart';

void setupTypeAdapters() {
  Hive.registerAdapter<Character>(CharacterTypeAdapter());
  Hive.registerAdapter<Class>(ClassTypeAdapter());
  Hive.registerAdapter<Size>(SizeTypeAdapter());
  Hive.registerAdapter<AbilityBonus>(AbilityBonusTypeAdapter());
  Hive.registerAdapter<AbilityScore>(AbilityScoreTypeAdapter());
}
