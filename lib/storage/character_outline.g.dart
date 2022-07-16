// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_outline.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterOutlineAdapter extends TypeAdapter<CharacterOutline> {
  @override
  final int typeId = 1;

  @override
  CharacterOutline read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterOutline(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      fields[3] as int,
      fields[4] as int,
      fields[5] as int,
      fields[6] as int,
      fields[7] as int,
      fields[8] as int,
      fields[9] as int,
      fields[10] as String,
      fields[11] as String,
      (fields[12] as List).cast<String>(),
      (fields[13] as List).cast<EquipmentIndexQuantity>(),
      (fields[14] as List).cast<String>(),
      (fields[15] as List).cast<String>(),
      (fields[16] as Map).cast<int, int>(),
      (fields[17] as Map).cast<int, int>(),
      (fields[18] as List).cast<UserFeature>(),
    );
  }

  @override
  void write(BinaryWriter writer, CharacterOutline obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.level)
      ..writeByte(2)
      ..write(obj.maxHp)
      ..writeByte(3)
      ..write(obj.hp)
      ..writeByte(4)
      ..write(obj.baseStrength)
      ..writeByte(5)
      ..write(obj.baseDexterity)
      ..writeByte(6)
      ..write(obj.baseConstitution)
      ..writeByte(7)
      ..write(obj.baseIntelligence)
      ..writeByte(8)
      ..write(obj.baseWisdom)
      ..writeByte(9)
      ..write(obj.baseCharisma)
      ..writeByte(10)
      ..write(obj.raceIndex)
      ..writeByte(11)
      ..write(obj.classIndex)
      ..writeByte(12)
      ..write(obj.proficiencyIndexes)
      ..writeByte(13)
      ..write(obj.allEquipment)
      ..writeByte(14)
      ..write(obj.preparedSpells)
      ..writeByte(15)
      ..write(obj.learnedSpells)
      ..writeByte(16)
      ..write(obj.usedSpellSlots)
      ..writeByte(17)
      ..write(obj.money)
      ..writeByte(18)
      ..write(obj.userFeatures);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterOutlineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EquipmentIndexQuantityAdapter
    extends TypeAdapter<EquipmentIndexQuantity> {
  @override
  final int typeId = 2;

  @override
  EquipmentIndexQuantity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EquipmentIndexQuantity(
      fields[0] as String,
      fields[1] as int,
      fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, EquipmentIndexQuantity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.isEquipped);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipmentIndexQuantityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
