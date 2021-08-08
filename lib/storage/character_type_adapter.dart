import 'package:dnd_player_flutter/storage/character_outline.dart';
import 'package:hive/hive.dart';


class CharacterTypeAdapter extends TypeAdapter<CharacterOutline> {
  @override
  int get typeId => 0;

  @override
  CharacterOutline read(BinaryReader reader) {
    return CharacterOutline(
      reader.readString(), // name
      reader.readInt(), // level
      reader.readInt(), // base strength
      reader.readInt(), // base dexterity
      reader.readInt(), // base constitution
      reader.readInt(), // base intelligence
      reader.readInt(), // base wisdom
      reader.readInt(), // base charisma

      reader.readString(), // race
      reader.readString(), // class

      readEquipmentIndexes(reader),
    );
  }

  List<String> readEquipmentIndexes(BinaryReader reader) {
    final equipment = <String>[];
    final total = reader.readInt();
    for (var i = 0; i < total; ++i) {
      equipment.add(reader.readString());
    }
    return equipment;
  }

  @override
  void write(BinaryWriter writer, CharacterOutline obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.level);
    writer.writeInt(obj.baseStrength);
    writer.writeInt(obj.baseDexterity);
    writer.writeInt(obj.baseConstitution);
    writer.writeInt(obj.baseIntelligence);
    writer.writeInt(obj.baseWisdom);
    writer.writeInt(obj.baseCharisma);

    writer.writeString(obj.raceIndex);
    writer.writeString(obj.classIndex);

    writer.writeInt(obj.equipmentIndexes.length);
    obj.equipmentIndexes.forEach((element) {
      writer.writeString(element);
    });
  }
}
