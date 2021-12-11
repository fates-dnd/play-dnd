enum Property {
  LIGHT,
  MONK,
  FINESSE,
  THROWN,
  TWO_HANDED,
  VERSATILE,
  AMMUNITION,
  LOADING,
  HEAVY,
  REACH,
  SPECIAL,
}

extension ToProperty on String? {
  Property? toProperty() {
    switch (this) {
      case "light":
        return Property.LIGHT;
      case "monk":
        return Property.MONK;
      case "finesse":
        return Property.FINESSE;
      case "thrown":
        return Property.THROWN;
      case "two-handed":
        return Property.TWO_HANDED;
      case "versatile":
        return Property.VERSATILE;
      case "ammunition":
        return Property.AMMUNITION;
      case "loading":
        return Property.LOADING;
      case "heavy":
        return Property.HEAVY;
      case "reach":
        return Property.REACH;
      case "special":
        return Property.SPECIAL;
      default:
        return null;
    }
  }
}
