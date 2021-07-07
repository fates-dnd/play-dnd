import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/storage/type_adapter_ids.dart';
import 'package:hive/hive.dart';

class SizeTypeAdapter extends TypeAdapter<Size> {
  @override
  int get typeId => SIZE_TYPE_ADAPTER;


  @override
  Size read(BinaryReader reader) {
    final index = reader.readInt();
    return Size.values[index];
  }

  @override
  void write(BinaryWriter writer, Size obj) {
    writer.write(obj.index);
  }

}