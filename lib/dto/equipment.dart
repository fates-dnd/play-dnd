class Equipment {
  final String index;
  final String name;
  final EquipmentCategory equipmentCategory;
  final double weight;
  final Cost cost;
  final String? weaponCategory;
  final String? weaponRange;
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

  bool get isEquippable => equipmentCategory != EquipmentCategory.ADVENTURING_GEAR;
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
  final String damageDice;
  final DamageType damageType;

  Damage(this.damageDice, this.damageType);
}

class DamageType {
  final String index;
  final String name;

  DamageType(this.index, this.name);
}

enum GearCategory {
  STANDARD_GEAR,
  HOLY_SYMBOLS,
  ACRANE_FOCI,
  DRUIDIC_FOCI,
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
