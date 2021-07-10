import 'package:dnd_player_flutter/storage/character_type_adapter.dart';
import 'package:hive/hive.dart';

import 'dto/character.dart';

void setupTypeAdapters() {
  Hive.registerAdapter<Character>(CharacterTypeAdapter());
}
