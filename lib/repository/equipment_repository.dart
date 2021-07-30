import 'dart:convert';

import 'package:dnd_player_flutter/dto/equipment.dart';

class EquipmentRepository {
  final Future<String> Function() jsonReader;

  EquipmentRepository(this.jsonReader);

  Future<List<Equipment>> getEquipment() async {
    final response = await jsonReader();
    final List<dynamic> equipmentJson = json.decode(response);
    return equipmentJson.map((item) => _fromJson(item)).toList();
  }

  Equipment _fromJson(Map<String, dynamic> json) {
    return Equipment(
      index: json["index"],
      name: json["name"],
      equipmentCategory: _equipmentCategoryFromJson(json["equipment_category"]),
      weight: json["weight"],
      cost: _costFromJson(json["cost"]),
      damage: _damageFromJson(json["damage"]),
      range: _rangeFromJson(json["range"]),
      properties: _propertiesFromJson(json["properties"]),
      throwRange: _throwRangeFromJson(json["throw_range"]),
      weaponCategory: json["weapon_category"],
      weaponRange: json["weapon_range"],
      categoryRange: json["category_range"],
      armorCategory: json["armor_category"],
      armorClass: _armorClassFromJson(json["armor_class"]),
      strMinimum: json["str_minimum"],
      stealthDisadvantage: json["stealth_disadvantage"],
      desc: json["desc"],
      gearCategory: _gearCategoryFromJson(json["gear_category"]),
    );
  }

  EquipmentCategory _equipmentCategoryFromJson(Map<String, dynamic> json) {
    return EquipmentCategory(
      json["index"],
      json["name"],
    );
  }

  Cost _costFromJson(Map<String, dynamic> json) {
    return Cost(
      json["quantity"],
      json["unit"],
    );
  }

  Damage _damageFromJson(Map<String, dynamic> json) {
    return Damage(
      json["damage_dice"],
      _damageTypeFromJson(json["damage_type"]),
    );
  }

  DamageType _damageTypeFromJson(Map<String, dynamic> json) {
    return DamageType(
      json["index"],
      json["name"],
    );
  }

  Range _rangeFromJson(Map<String, dynamic> json) {
    return Range(
      json["normal"],
      json["long"],
    );
  }

  List<Property> _propertiesFromJson(List<dynamic> json) {
    return json
        .map((property) => Property(
              property["index"],
              property["name"],
            ))
        .toList();
  }

  ThrowRange _throwRangeFromJson(Map<String, dynamic> json) {
    return ThrowRange(
      json["normal"],
      json["long"],
    );
  }

  ArmorClass _armorClassFromJson(Map<String, dynamic> json) {
    return ArmorClass(
      json["base"],
      json["dex_bonus"],
      json["max_bonus"],
    );
  }

  GearCategory _gearCategoryFromJson(Map<String, dynamic> json) {
    return GearCategory(
      json["index"],
      json["name"],
    );
  }
}
