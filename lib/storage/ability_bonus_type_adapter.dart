import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/storage/type_adapter_ids.dart';
import 'package:hive/hive.dart';

class AbilityBonusTypeAdapter extends TypeAdapter<AbilityBonus> {

  @override
  int get typeId => ABILITY_BONUS_TYPE_ADAPTER;
  
  @override
  AbilityBonus read(BinaryReader reader) {
    return AbilityBonus(
      reader.read(ABILITY_SCORE_ADAPTER), 
      reader.readInt()
    );
  }

  @override
  void write(BinaryWriter writer, AbilityBonus abilityBonus) {
    writer.write(abilityBonus.abilityScore);
    writer.write(abilityBonus.bonus);
  }
}
