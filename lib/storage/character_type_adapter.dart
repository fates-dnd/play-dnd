import 'package:dnd_player_flutter/dto/rest.dart';
import 'package:dnd_player_flutter/dto/user_feature.dart';
import 'package:dnd_player_flutter/storage/character_outline.dart';
import 'package:hive/hive.dart';

class CharacterTypeAdapter extends TypeAdapter<CharacterOutline?> {
  @override
  int get typeId => 0;

  @override
  CharacterOutline? read(BinaryReader reader) {
    try {
      return CharacterOutline(
        reader.readString(),
        // name
        reader.readInt(),
        // level
        reader.readInt(),
        // maxHp
        reader.readInt(),
        // hp
        reader.readInt(),
        // base strength
        reader.readInt(),
        // base dexterity
        reader.readInt(),
        // base constitution
        reader.readInt(),
        // base intelligence
        reader.readInt(),
        // base wisdom
        reader.readInt(),
        // base charisma

        reader.readString(),
        // race
        reader.readString(),
        // class

        readStringList(reader),
        // proficiency indexes

        readEquipmentQuantities(reader),
        // equipment indexes

        readStringList(reader),
        // prepared spells
        readStringList(reader),
        // learned spells

        reader.readMap().cast(),
        // spell slots
        reader.readMap().cast(),
        // money

        reader.readMap().cast(), // feature usage

        readUserFeatures(reader),
      );
    } catch (e) {
      return null;
    }
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

  List<UserFeature> readUserFeatures(BinaryReader reader) {
    final result = <UserFeature>[];
    final total = reader.readInt();
    for (var i = 0; i < total; ++i) {
      result.add(readUserFeature(reader));
    }
    return result;
  }

  UserFeature readUserFeature(BinaryReader reader) {
    final name = reader.readString();
    final description = reader.readString();
    final isUsageAvailable = reader.readBool();

    Usage? usage;
    if (isUsageAvailable) {
      final usages = reader.readInt();
      final resetsOn = Rest.values[reader.readInt()];
      usage = Usage(usages, resetsOn);
    }

    return UserFeature(name: name, description: description, usage: usage);
  }

  @override
  void write(BinaryWriter writer, CharacterOutline? obj) {
    if (obj == null) {
      throw ArgumentError("Do not store null CharacterOutline");
    }

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
    writer.writeMap(obj.money);

    writer.writeMap(obj.featureUsage);

    writeUserFeatures(writer, obj.userFeatures);
  }

  void writeUserFeatures(BinaryWriter writer, List<UserFeature> userFeatures) {
    writer.write(userFeatures.length);
    userFeatures.forEach((feature) {
      writeUserFeature(writer, feature);
    });
  }

  void writeUserFeature(BinaryWriter writer, UserFeature userFeature) {
    writer.write(userFeature.name);
    writer.write(userFeature.description);

    final usage = userFeature.usage;

    final isUsageAvailable = usage != null;
    writer.writeBool(isUsageAvailable);
    if (isUsageAvailable) {
      writer.write(usage!.usages);
      writer.write(usage.resetsOn?.index);
    }
  }
}
