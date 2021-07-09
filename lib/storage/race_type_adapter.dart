import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/storage/type_adapter_ids.dart';
import 'package:hive/hive.dart';

class RaceTypeAdapter extends TypeAdapter<Race> {

  @override
  int get typeId => RACE_TYPE_ADAPTER;

  @override
  Race read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return Race(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as String,
      fields[5] as List<AbilityBonus>,
      fields[6] as AbilityBonusOptions?,
      fields[7] as String,
      fields[8] as String,
      fields[9] as Size,
      fields[10] as String,
      fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Race race) {
    writer.writeByte(12);
    writer.writeByte(0);
    writer.write(race.index);
    writer.writeByte(1);
    writer.write(race.name);
    writer.writeByte(2);
    writer.write(race.description);
    writer.writeByte(3);
    writer.write(race.baseSpeed);
    writer.writeByte(4);
    writer.write(race.abilityBonusDescription);
    writer.writeByte(5);
    writer.writeList(race.abilityBonuses);
    writer.writeByte(6);
    writer.write(race.abilityBonusOptions);
    writer.writeByte(7);
    writer.write(race.age);
    writer.writeByte(8);
    writer.write(race.alignment);
    writer.writeByte(9);
    writer.write(race.size);
    writer.writeByte(10);
    writer.write(race.sizeDescription);
    writer.writeByte(11);
    writer.write(race.languagesDescription);
  }
}
