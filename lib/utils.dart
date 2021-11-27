import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension FirstWhereOrNullExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension ToBonusNumber on int {
  String toBonusString() {
    if (this >= 0) {
      return "+$this";
    } else {
      return this.toString();
    }
  }
}

extension CharacteristicColor on Characteristic {
  Color getColor() {
    return characteristicToColor[this] ?? Colors.yellow;
  }

  static Map<Characteristic, Color> characteristicToColor = {
    Characteristic.STRENGTH: Color(0xFFFF5251),
    Characteristic.DEXTERITY: Color(0xFF3AFFBD),
    Characteristic.CONSTITUTION: Color(0xFFFB9538),
    Characteristic.INTELLIGENCE: Color(0xFFE5E1DE),
    Characteristic.WISDOM: Color(0xFF4847FB),
    Characteristic.CHARISMA: Color(0xFFC01DFC),
  };
}

extension EquipmentWeaponRangeName on Equipment {
  String getWeaponRangeName(BuildContext context) {
    return (weaponRange == WeaponRange.MELEE
        ? AppLocalizations.of(context)!.melee
        : "${range?.normal} / ${range?.long}");
  }
}

extension EquipmentCategoryName on EquipmentCategory {
  String getName(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    switch (this) {
      case EquipmentCategory.WEAPON:
        return localization.weapon;
      case EquipmentCategory.ARMOR:
        return localization.armor;
      case EquipmentCategory.ADVENTURING_GEAR:
        return localization.adventuring_gear;
    }
  }
}
