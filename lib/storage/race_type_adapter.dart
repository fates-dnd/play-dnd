import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/storage/type_adapter_ids.dart';
import 'package:hive/hive.dart';

class RaceTypeAdapter extends TypeAdapter<Race> {

  @override
  int get typeId => RACE_TYPE_ADAPTER;

  @override
  Race read(BinaryReader reader) {
    return Race(
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readInt(),
      reader.readString(),
      reader.readList(ABILITY_BONUS_TYPE_ADAPTER) as List<AbilityBonus>,
      reader.read(ABILITY_BONUS_OPTIONS_ADAPTER),
      reader.readString(),
      reader.readString(),
      reader.read(SIZE_TYPE_ADAPTER),
      reader.readString(),
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Race race) {
    writer.write(race.index);
    writer.write(race.name);
    writer.write(race.description);
    writer.write(race.baseSpeed);
    writer.write(race.abilityBonusDescription);
    writer.writeList(race.abilityBonuses);
    writer.write(race.abilityBonusOptions);
    writer.write(race.age);
    writer.write(race.alignment);
    writer.write(race.size);
    writer.write(race.sizeDescription);
    writer.write(race.languagesDescription);
  }
}
