import 'package:dnd_player_flutter/dto/equipment.dart';

extension EquipmentCategoryLocale on EquipmentCategory {

  String getName() {
    switch (this) {
      case EquipmentCategory.WEAPON:
        return "Оружие";
      case EquipmentCategory.ARMOR:
        return "Броня";
      case EquipmentCategory.ADVENTURING_GEAR:
        return "Приспособление";
    }
  }
}

extension EquipmentWeaponRangLocale on WeaponRange {

  String getName() {
    switch (this) {
      case WeaponRange.MELEE: 
        return "Ближний бой";
      default: 
        return "";
    }
  }
}
