enum Characteristic {
  STRENGTH,
  DEXTERITY,
  CONSTITUTION,
  INTELLECT,
  WISDOM,
  CHARISMA
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
