// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestAdapter extends TypeAdapter<Rest> {
  @override
  final int typeId = 5;

  @override
  Rest read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Rest.SHORT;
      case 1:
        return Rest.LONG;
      default:
        return Rest.SHORT;
    }
  }

  @override
  void write(BinaryWriter writer, Rest obj) {
    switch (obj) {
      case Rest.SHORT:
        writer.writeByte(0);
        break;
      case Rest.LONG:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
