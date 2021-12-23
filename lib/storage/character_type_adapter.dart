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
        reader.readInt(), // maxHp
        reader.readInt(), // hp
        reader.readInt(), // base strength
        reader.readInt(), // base dexterity
        reader.readInt(), // base constitution
        reader.readInt(), // base intelligence
        reader.readInt(), // base wisdom
        reader.readInt(), // base charisma

        reader.readString(), // race
        reader.readString(), // class

        readStringList(reader), // proficiency indexes

        readEquipmentQuantities(reader), // equipment indexes

        readStringList(reader), // prepared spells
        readStringList(reader), // learned spells

        reader.readMap().cast() // spell slots
        );
  }

  List<EquipmentIndexQuantity> readEquipmentQuantities(BinaryReader reader) {
    final result = <EquipmentIndexQuantity>[];
    final total = reader.readInt();
    for (var i = 0; i < total; ++i) {
      final item = EquipmentIndexQuantity(
        reader.readString(),
        reader.readInt(),
        reader.readBool(),
      );
      result.add(item);
    }
    return result;
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
    writer.writeInt(obj.maxHp);
    writer.writeInt(obj.hp);
    writer.writeInt(obj.baseStrength);
    writer.writeInt(obj.baseDexterity);
    writer.writeInt(obj.baseConstitution);
    writer.writeInt(obj.baseIntelligence);
    writer.writeInt(obj.baseWisdom);
    writer.writeInt(obj.baseCharisma);

    writer.writeString(obj.raceIndex);
    writer.writeString(obj.classIndex);

    writer.writeInt(obj.proficiencyIndexes.length);
    obj.proficiencyIndexes.forEach((element) {
      writer.writeString(element);
    });

    writer.writeInt(obj.allEquipment.length);
    obj.allEquipment.forEach((indexQuantity) {
      writer.writeString(indexQuantity.index);
      writer.writeInt(indexQuantity.quantity);
      writer.writeBool(indexQuantity.isEquipped);
    });

    writer.writeInt(obj.preparedSpells.length);
    obj.preparedSpells.forEach((element) {
      writer.writeString(element);
    });

    writer.writeInt(obj.learnedSpells.length);
    obj.learnedSpells.forEach((element) {
      writer.writeString(element);
    });

    writer.writeMap(obj.usedSpellSlots);
  }
}
