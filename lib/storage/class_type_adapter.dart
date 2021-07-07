import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/storage/type_adapter_ids.dart';
import 'package:hive/hive.dart';

class ClassTypeAdapter extends TypeAdapter<Class> {

  @override
  int get typeId => CLASS_TYPE_ADAPTER;

  @override
  Class read(BinaryReader reader) {
    return Class(
      reader.readString(),
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Class obj) {
    writer.write(obj.index);
    writer.write(obj.name);
  }
}
