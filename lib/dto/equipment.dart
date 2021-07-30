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
  final String? armorCategory;
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
}

class EquipmentCategory {
  final String index;
  final String name;

  EquipmentCategory(this.index, this.name);
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

class GearCategory {
  final String index;
  final String name;

  GearCategory(this.index, this.name);
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