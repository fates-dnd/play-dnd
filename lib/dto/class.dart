class Class {

  final String index;
  final String name;

  String? get imageAsset => _indexToImageAsset();

  Class(this.index, this.name);
}

extension OnClass on Class {
  String? _indexToImageAsset() {
    switch (index) {
      case "barbarian": 
        return "";
      case "bard":
        return "";
      case "cleric":
        return "";
      case "druid":
        return "";
      case "fighter":
        return "";
      case "monk":
        return "";
      case "paladin":
        return "";
      case "ranger":
        return "";
      case "rogue":
        return "";
      case "sorcerer":
        return "";
      case "warlock":
        return "";
      case "wizard":
        return "";
      default: return null;
    }
  }
}
