import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/storage/type_adapter_ids.dart';
import 'package:hive/hive.dart';

class AbilityScoreTypeAdapter extends TypeAdapter<AbilityScore> {

  @override
  int get typeId => ABILITY_SCORE_ADAPTER;

  @override
  AbilityScore read(BinaryReader reader) {
    return AbilityScore(
      reader.readString(), 
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, AbilityScore abilityScore) {
    writer.write(abilityScore.index);
    writer.write(abilityScore.name);
  }
}
