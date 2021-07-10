import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:hive/hive.dart';

part 'character_reader.dart';
part 'character_writer.dart';

class CharacterTypeAdapter extends TypeAdapter<Character> {
  @override
  int get typeId => 0;

  @override
  Character read(BinaryReader reader) {
    return Character(
      reader.readString(),
      reader.readRace(),
      reader.readClass(),
    );
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer.writeString(obj.name);
    writer.writeRace(obj.race);
    writer.writeClass(obj.clazz);
  }
}
