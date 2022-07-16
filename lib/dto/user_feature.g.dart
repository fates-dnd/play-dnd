// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_feature.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserFeatureAdapter extends TypeAdapter<UserFeature> {
  @override
  final int typeId = 3;

  @override
  UserFeature read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserFeature(
      name: fields[0] as String,
      description: fields[1] as String,
      usage: fields[2] as Usage?,
    );
  }

  @override
  void write(BinaryWriter writer, UserFeature obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.usage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserFeatureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UsageAdapter extends TypeAdapter<Usage> {
  @override
  final int typeId = 4;

  @override
  Usage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Usage(
      fields[0] as int,
      fields[1] as Rest?,
    );
  }

  @override
  void write(BinaryWriter writer, Usage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.usages)
      ..writeByte(1)
      ..write(obj.resetsOn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
