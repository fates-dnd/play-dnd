class Class {

  final String index;
  final String name;

  String get imageAsset => _indexToImageAsset();

  Class(this.index, this.name);
}

extension OnClass on Class {
  String _indexToImageAsset() {
    switch (index) {
      case "barbarian": 
        return "assets/icons/barbarian.png";
      case "bard":
        return "assets/icons/bard.png";
      case "cleric":
        return "assets/icons/cleric.png";
      case "druid":
        return "assets/icons/druid.png";
      case "fighter":
        return "assets/icons/fighter.png";
      case "monk":
        return "assets/icons/monk.png";
      case "paladin":
        return "assets/icons/paladin.png";
      case "ranger":
        return "assets/icons/ranger.png";
      case "rogue":
        return "assets/icons/rogue.png";
      case "sorcerer":
        return "assets/icons/sorcerer.png";
      case "warlock":
        return "assets/icons/warlock.png";
      case "wizard":
        return "assets/icons/wizard.png";
      default: return "";
    }
  }
}
