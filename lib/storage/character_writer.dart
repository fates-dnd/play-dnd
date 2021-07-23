part of 'character_type_adapter.dart';

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

  writeClass(Class clazz) {
    writeString(clazz.index);
    writeString(clazz.name);
    writeSavingThrows(clazz.savingThrows);
  }

  writeSavingThrows(List<Characteristic> savingThrows) {
    writeInt(savingThrows.length);
    savingThrows.forEach((element) {
      writeInt(element.index);
    });
  }
}
