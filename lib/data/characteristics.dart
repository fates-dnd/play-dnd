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
