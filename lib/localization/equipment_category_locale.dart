import 'package:dnd_player_flutter/dto/equipment.dart';

extension EquipmentCategoryLocal on EquipmentCategory {

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
