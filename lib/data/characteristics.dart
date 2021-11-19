import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Characteristic {
  STRENGTH,
  DEXTERITY,
  CONSTITUTION,
  INTELLIGENCE,
  WISDOM,
  CHARISMA
}

Characteristic requireFromIndex(String index) {
  final result = fromIndex(index);
  if (result == null) {
    throw ArgumentError("No characteristic for $index");
  }

  return result;
}

Characteristic? fromIndex(String index) {
  switch (index) {
    case "str":
      return Characteristic.STRENGTH;
    case "dex":
      return Characteristic.DEXTERITY;
    case "con":
      return Characteristic.CONSTITUTION;
    case "int":
      return Characteristic.INTELLIGENCE;
    case "wis":
      return Characteristic.WISDOM;
    case "cha":
      return Characteristic.CHARISMA;
  }

  return null;
}

class CharacteristicBonus {
  final Characteristic characteristic;
  final int bonus;

  CharacteristicBonus(this.characteristic, this.bonus);
}

extension Name on Characteristic {
  String getName(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (this) {
      case Characteristic.STRENGTH:
        return localizations.strength;
      case Characteristic.DEXTERITY:
        return localizations.dexterity;
      case Characteristic.CONSTITUTION:
        return localizations.constitution;
      case Characteristic.INTELLIGENCE:
        return localizations.intelligence;
      case Characteristic.WISDOM:
        return localizations.wisdom;
      case Characteristic.CHARISMA:
        return localizations.charisma;
    }
  }
}
