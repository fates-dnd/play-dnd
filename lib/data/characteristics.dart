abstract class Characteristic {

  String get name;
}

class Strength extends Characteristic {

  @override
  String get name => "Сила";
}

class Dexterity extends Characteristic {

  @override
  String get name => "Ловкость";

}

class Constitution extends Characteristic {

  @override
  String get name => "Телосложение";
}

class Intellect extends Characteristic {

  @override
  String get name => "Интеллект";
}

class Wisdom extends Characteristic {

  @override
  String get name => "Мудрость";
}

class Charisma extends Characteristic {

  @override
  String get name => "Харизма";
}
