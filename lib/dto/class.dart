import 'package:dnd_player_flutter/data/characteristics.dart';

class Class {
  final String index;
  final String name;
  final List<Characteristic> savingThrows;
  final Characteristic? spellcastingAbility;

  String get imageAsset => _indexToImageAsset();

  Class(
    this.index,
    this.name,
    this.savingThrows,
    this.spellcastingAbility,
  );
}

extension OnClass on Class {
  String _indexToImageAsset() {
    switch (index) {
      case "barbarian":
        return "assets/drawable/icons/barbarian.png";
      case "bard":
        return "assets/drawable/icons/bard.png";
      case "cleric":
        return "assets/drawable/icons/cleric.png";
      case "druid":
        return "assets/drawable/icons/druid.png";
      case "fighter":
        return "assets/drawable/icons/fighter.png";
      case "monk":
        return "assets/drawable/icons/monk.png";
      case "paladin":
        return "assets/drawable/icons/paladin.png";
      case "ranger":
        return "assets/drawable/icons/ranger.png";
      case "rogue":
        return "assets/drawable/icons/rogue.png";
      case "sorcerer":
        return "assets/drawable/icons/sorcerer.png";
      case "warlock":
        return "assets/drawable/icons/warlock.png";
      case "wizard":
        return "assets/drawable/icons/wizard.png";
      default:
        return "";
    }
  }
}
