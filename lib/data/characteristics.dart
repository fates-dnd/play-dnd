enum Characteristic {

  STRENGTH,
  DEXTERITY,
  CONSTITUTION,
  INTELLECT,
  WISDOM,
  CHARISMA
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

    return "";
  }
}
