import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/storage/type_adapter_ids.dart';
import 'package:hive/hive.dart';

class CharacterTypeAdapter extends TypeAdapter<Character> {
  @override
  int get typeId => CHARACTER_TYPE_ADAPTER;

  @override
  Character read(BinaryReader reader) {
    return Character(
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer.writeString(obj.name);
  }
}
