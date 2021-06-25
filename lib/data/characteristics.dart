enum Characteristic {
  STRENGTH,
  DEXTERITY,
  CONSTITUTION,
  INTELLECT,
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
      return Characteristic.INTELLECT;
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
  String getName() {
    switch (this) {
      case Characteristic.STRENGTH:
        return "Сила";
      case Characteristic.DEXTERITY:
        return "Ловкость";
      case Characteristic.CONSTITUTION:
        return "Телосложение";
      case Characteristic.INTELLECT:
        return "Интеллект";
      case Characteristic.WISDOM:
        return "Мудрость";
      case Characteristic.CHARISMA:
        return "Харизма";
    }
  }
}
