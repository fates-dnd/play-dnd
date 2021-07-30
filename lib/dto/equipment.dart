class Equipment {
  final String index;
  final String name;
  final EquipmentCategory equipmentCategory;
  final String? weaponCategory;
  final String? weaponRange;
  final String? categoryRange;
  final String? armorCategory;
  final ArmorClass? armorClass;
  final int? strMinimum;
  final bool? stealthDisadvantage;
  final int weight;
  final Cost cost;
  final GearCategory gearCategory;
  final List<String> desc;

  Equipment(
      this.index,
      this.name,
      this.equipmentCategory,
      this.weaponCategory,
      this.weaponRange,
      this.categoryRange,
      this.armorCategory,
      this.armorClass,
      this.strMinimum,
      this.stealthDisadvantage,
      this.weight,
      this.cost,
      this.gearCategory,
      this.desc,);
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
