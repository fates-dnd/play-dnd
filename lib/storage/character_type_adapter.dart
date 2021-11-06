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

      readStringList(reader), // equipment indexes
      readStringList(reader), // equipped items indexes

      readStringList(reader), // prepared spells
      readStringList(reader), // learned spells
    );
  }

  List<String> readStringList(BinaryReader reader) {
    final result = <String>[];
    final total = reader.readInt();
    for (var i = 0; i < total; ++i) {
      result.add(reader.readString());
    }
    return result;
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

    writer.writeInt(obj.equippedItems.length);
    obj.equippedItems.forEach((element) {
      writer.writeString(element);
    });

    writer.writeInt(obj.preparedSpells.length);
    obj.preparedSpells.forEach((element) {
      writer.writeString(element);
    });

    writer.writeInt(obj.learnedSpells.length);
    obj.learnedSpells.forEach((element) {
      writer.writeString(element);
    });
  }
}
