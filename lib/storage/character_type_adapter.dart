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
      reader.readString(), // name
      reader.readInt(), // level
      reader.readInt(), // base strength
      reader.readInt(), // base dexterity
      reader.readInt(), // base constitution
      reader.readInt(), // base intelligence
      reader.readInt(), // base wisdom
      reader.readInt(), // base charisma

      reader.readRace(),
      reader.readClass(),
    );
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.level);
    writer.writeInt(obj.baseStrength);
    writer.writeInt(obj.baseDexterity);
    writer.writeInt(obj.baseConstitution);
    writer.writeInt(obj.baseIntelligence);
    writer.writeInt(obj.baseWisdom);
    writer.writeInt(obj.baseCharisma);

    writer.writeRace(obj.race);
    writer.writeClass(obj.clazz);
  }
}
