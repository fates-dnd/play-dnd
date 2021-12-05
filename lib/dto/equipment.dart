import 'package:dnd_player_flutter/data/dice.dart';
import 'package:equatable/equatable.dart';

import 'damage_type.dart';

class Equipment extends Equatable {
  final String index;
  final String name;
  final EquipmentCategory equipmentCategory;
  final double? weight;
  final Cost cost;
  final String? weaponCategory;
  final WeaponRange? weaponRange;
  final String? categoryRange;
  final Damage? damage;
  final ArmorCategory? armorCategory;
  final ArmorClass? armorClass;
  final int? strMinimum;
  final bool? stealthDisadvantage;
  final GearCategory? gearCategory;
  final List<String>? desc;
  final Range? range;
  final List<Property>? properties;
  final ThrowRange? throwRange;

  Equipment({
    required this.index,
    required this.name,
    required this.equipmentCategory,
    required this.weight,
    required this.cost,
    this.weaponCategory,
    this.weaponRange,
    this.damage,
    this.categoryRange,
    this.armorCategory,
    this.armorClass,
    this.strMinimum,
    this.stealthDisadvantage,
    this.gearCategory,
    this.desc,
    this.range,
    this.properties,
    this.throwRange,
  });

  bool get isEquippable =>
      equipmentCategory != EquipmentCategory.ADVENTURING_GEAR;

  bool get isStackable =>
      equipmentCategory == EquipmentCategory.ADVENTURING_GEAR;

  @override
  List<Object?> get props => [index, name];
}

enum EquipmentCategory {
  WEAPON,
  ARMOR,
  ADVENTURING_GEAR,
}

class ArmorClass {
  final int base;
  final bool? dexBonus;
  final int? maxBonus;

  ArmorClass(
    this.base,
    this.dexBonus,
    this.maxBonus,
  );
}

class Cost {
  final int quantity;
  final String unit;

  Cost(this.quantity, this.unit);
}

class Damage {
  final DamageDice damageDice;
  final DamageType? damageType;

  Damage(this.damageDice, this.damageType);
}

class DamageDice {
  final int amount;
  final Dice dice;

  DamageDice(this.amount, this.dice);
}

enum GearCategory {
  STANDARD_GEAR,
  HOLY_SYMBOLS,
  ACRANE_FOCI,
  DRUIDIC_FOCI,
}

enum WeaponRange {
  MELEE,
  RANGED,
}

class Range {
  final int normal;
  final int? long;

  Range(this.normal, this.long);
}

class Property {
  final String index;
  final String name;

  Property(this.index, this.name);
}

class ThrowRange {
  final int normal;
  final int long;

  ThrowRange(this.normal, this.long);
}

enum ArmorCategory {
  SHIELD,
  LIGHT,
  MEDIUM,
  HEAVY,
}
