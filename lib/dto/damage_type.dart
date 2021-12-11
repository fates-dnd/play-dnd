enum DamageType {
  ACID,
  SLASHING,
  NECROTIC,
  RADIANT,
  FIRE,
  LIGHTNING,
  POISON,
  COLD,
  BLUDGEONING,
  FORCE,
  PSYCHIC,
  PIERCING,
  THUNDER,
}

extension ToDamageType on String? {
  DamageType? toDamageType() {
    switch (this) {
      case "acid":
        return DamageType.ACID;
      case "slashing":
        return DamageType.SLASHING;
      case "necrotic":
        return DamageType.NECROTIC;
      case "radiant":
        return DamageType.RADIANT;
      case "fire":
        return DamageType.FIRE;
      case "lightning":
        return DamageType.LIGHTNING;
      case "poison":
        return DamageType.POISON;
      case "cold":
        return DamageType.COLD;
      case "bludgeoning":
        return DamageType.BLUDGEONING;
      case "force":
        return DamageType.FORCE;
      case "psychic":
        return DamageType.PSYCHIC;
      case "piercing":
        return DamageType.PIERCING;
      case "thunder":
        return DamageType.THUNDER;
      default:
        return null;
    }
  }
}
