class Spell {
  final String index;
  final String name;
  final List<String> description;
  final String range;
  final List<String> components;
  final bool ritual;
  final String duration;
  final String castingTime;
  final int level;
  final Damage damage;
  final Dc dc;
  final School school;
  final List<String> classesIds;

  Spell(
    this.index,
    this.name,
    this.description,
    this.range,
    this.components,
    this.ritual,
    this.duration,
    this.castingTime,
    this.level,
    this.damage,
    this.dc,
    this.school,
    this.classesIds,
  );
}

class Damage {
  final DamageType damageType;
  final Map<String, String> damageAtCharacterLevel;

  Damage(
    this.damageType,
    this.damageAtCharacterLevel,
  );
}

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

class Dc {
  final DcType dcType;
  final DcSuccess dcSuccess;
  final String description;

  Dc(
    this.dcType,
    this.dcSuccess,
    this.description,
  );
}

enum DcType {
  STR,
  DEX,
  CON,
  INT,
  WIS,
  CHA,
}

enum DcSuccess {
  NONE,
  HALF,
  OTHER,
}

enum AreaOfEffect {
  CONE,
  SPHERE,
  CUBE,
  CYLINDER,
  LINE,
}

enum School {
  ENCHANTMEN,
  ABJURATION,
  TRANSMUTATION,
  NECROMANCY,
  EVOCATION,
  ILLUSION,
  CONJURATION,
  DIVINATION,
}
