import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/storage/type_adapter_ids.dart';
import 'package:hive/hive.dart';

class CharacterTypeAdapter extends TypeAdapter<Character> {
  @override
  int get typeId => CHARACTER_TYPE_ADAPTER;

  @override
  Character read(BinaryReader reader) {
    return Character(
      reader.readString(),
      reader.readRace()
    );
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer.writeString(obj.name);
    writer.writeRace(obj.race);
  }
}

extension CharacterReader on BinaryReader {
  Race readRace() {
    return Race(
      readString(),
      readString(),
      readString(),
      readInt(),
      readString(),
      readAbilityBonuses(),
      readAbilityBonusOptions(),
      readString(),
      readString(),
      readSize(),
      readString(),
      readString(),
    );
  }

  List<AbilityBonus> readAbilityBonuses() {
    final count = readInt();
    final result = <AbilityBonus>[];
    for (var i = 0; i < count; ++i) {
      result.add(AbilityBonus(
        AbilityScore(
          readString(),
          readString(),
        ), readInt()
      ));
    }
    return result;
  }

  AbilityBonusOptions? readAbilityBonusOptions() {
    final optionsAvailable = readBool();
    if (!optionsAvailable) {
      return null;
    }

    return AbilityBonusOptions(
      readInt(),
      readAbilityBonuses(),
    );
  }

  Size readSize() {
    return Size.values[readInt()];
  }
}

extension CharacterWriter on BinaryWriter {
  writeRace(Race race) {
    writeString(race.index);
    writeString(race.name);
    writeString(race.description);
    writeInt(race.baseSpeed);
    writeString(race.abilityBonusDescription);
    writeAbilityBonuses(race.abilityBonuses);
    writeAbilityBonusOptions(race.abilityBonusOptions);
    writeString(race.age);
    writeString(race.alignment);
    writeSize(race.size);
    writeString(race.sizeDescription);
    writeString(race.languagesDescription);
  }

  writeAbilityBonuses(List<AbilityBonus> abilityBonuses) {
    writeInt(abilityBonuses.length);
    abilityBonuses.forEach((element) { 
      writeString(element.abilityScore.index);
      writeString(element.abilityScore.name);
      writeInt(element.bonus);
    });
  }

  writeAbilityBonusOptions(AbilityBonusOptions? abilityBonusOptions) {
    if (abilityBonusOptions == null) {
      writeBool(false); // no ability bonus options
      return;
    }

    writeBool(true); // available bonus options
    writeInt(abilityBonusOptions.choose);
    writeAbilityBonuses(abilityBonusOptions.abilityBonuses);
  }

  writeSize(Size size) {
    writeInt(size.index);
  }
}
