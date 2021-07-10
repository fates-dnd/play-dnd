part of 'character_type_adapter.dart';

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

  Class readClass() {
    return Class(
      readString(),
      readString(),
    );
  }
}
