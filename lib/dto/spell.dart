import 'package:dnd_player_flutter/data/characteristics.dart';

import 'damage_type.dart';

class Spell {
  final String index;
  final String name;
  final List<String> description;
  final String range;
  final List<Component> components;
  final String? material;
  final bool ritual;
  final String duration;
  final bool concentration;
  final String castingTime;
  final int level;
  final Map<String, String>? healAtSlotLevel;
  final Damage? damage;
  final Dc? dc;
  final School school;
  final List<String> classesIds;

  Spell(
    this.index,
    this.name,
    this.description,
    this.range,
    this.components,
    this.material,
    this.ritual,
    this.duration,
    this.concentration,
    this.castingTime,
    this.level,
    this.healAtSlotLevel,
    this.damage,
    this.dc,
    this.school,
    this.classesIds,
  );
}

enum Component {
  VERBAL,
  SOMATIC,
  MATERIAL,
}

class Damage {
  final DamageType? damageType;
  final Map<String, String>? damageAtCharacterLevel;
  final Map<String, String>? damageAtSlotLevel;

  Damage(
    this.damageType,
    this.damageAtCharacterLevel,
    this.damageAtSlotLevel,
  );
}

class Dc {
  final Characteristic dcType;
  final DcSuccess dcSuccess;
  final String? description;

  Dc(
    this.dcType,
    this.dcSuccess,
    this.description,
  );
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
  ENCHANTMENT,
  ABJURATION,
  TRANSMUTATION,
  NECROMANCY,
  EVOCATION,
  ILLUSION,
  CONJURATION,
  DIVINATION,
}
