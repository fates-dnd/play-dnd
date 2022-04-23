import 'package:dnd_player_flutter/storage/character_outline.dart';
import 'package:dnd_player_flutter/storage/character_type_adapter.dart';
import 'package:hive/hive.dart';

void setupTypeAdapters() {
  Hive.registerAdapter<CharacterOutline?>(CharacterTypeAdapter());
}
