import 'package:dnd_player_flutter/data/characteristics.dart';

Characteristic indexAsCharacteristic(String index) {
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
    default:
      throw ArgumentError("Index $index is not a characteristic.");
  }
}
