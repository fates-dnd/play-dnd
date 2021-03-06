import 'dart:convert';

import 'package:dnd_player_flutter/data/dice.dart';
import 'package:dnd_player_flutter/dto/damage_type.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/dto/equipment_property.dart';

class EquipmentRepository {
  final Future<String> Function(String lang) jsonReader;

  List<Equipment>? loadedEquipment;
  String? language;

  EquipmentRepository(this.jsonReader);

  Future<List<Equipment>> getEquipment(String language) async {
    if (this.language == language && loadedEquipment != null) {
      return loadedEquipment!;
    }

    this.language = language;

    final response = await jsonReader(language);
    final List<dynamic> equipmentJson = json.decode(response);
    final parsedEquipment =
        equipmentJson.map((item) => _fromJson(item)).toList();
    loadedEquipment = parsedEquipment.map((equipment) {
      if (equipment.contents == null) {
        return equipment;
      }

      final json = equipmentJson
          .firstWhere((element) => element["index"] == equipment.index);

      return equipment.copyWithContents((json["contents"] as List<dynamic>)
          .map((e) => parsedEquipment
              .firstWhere((element) => element.index == e["item"]["index"]))
          .toList());
    }).toList();

    return loadedEquipment!;
  }

  Future<List<Equipment>> findByIndexes(
      String language, List<String> indexes) async {
    final equipment = await getEquipment(language);
    return indexes
        .map((index) =>
            equipment.firstWhere((element) => element.index == index))
        .toList();
  }

  Equipment _fromJson(Map<String, dynamic> json) {
    return Equipment(
      index: json["index"],
      name: json["name"],
      equipmentCategory: _equipmentCategoryFromJson(json["equipment_category"]),
      weight: json["weight"]?.toDouble(),
      cost: _costFromJson(json["cost"]),
      damage: _damageFromJson(json["damage"] ?? null),
      range: _rangeFromJson(json["range"] ?? null),
      properties: _propertiesFromJson(json["properties"] ?? null),
      throwRange: _throwRangeFromJson(json["throw_range"] ?? null),
      weaponCategory: json["weapon_category"],
      weaponRange: _weaponRangeFromJson(json["weapon_range"]),
      categoryRange: json["category_range"],
      armorCategory: (json["armor_category"] as String?).toArmorCategory(),
      armorClass: _armorClassFromJson(json["armor_class"] ?? {}),
      strMinimum: json["str_minimum"],
      stealthDisadvantage: json["stealth_disadvantage"],
      desc: _descriptionFromJson(json["desc"]),
      gearCategory: _gearCategoryFromJson(json["gear_category"] ?? null),
      contents: json["contents"] != null ? [] : null,
    );
  }

  EquipmentCategory _equipmentCategoryFromJson(Map<String, dynamic> json) {
    final index = json["index"];
    switch (index) {
      case "weapon":
        return EquipmentCategory.WEAPON;
      case "armor":
        return EquipmentCategory.ARMOR;
      case "adventuring-gear":
        return EquipmentCategory.ADVENTURING_GEAR;
      default:
        return EquipmentCategory.ADVENTURING_GEAR;
    }
  }

  Cost _costFromJson(Map<String, dynamic> json) {
    return Cost(
      json["quantity"],
      json["unit"],
    );
  }

  Damage? _damageFromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return Damage(
      _damageDiceFromString(json["damage_dice"]),
      (json["damage_type"]?["index"] as String?).toDamageType(),
    );
  }

  /// Parse damage dice from string like:
  /// 1d20
  /// 2d6
  /// 1d10
  DamageDice _damageDiceFromString(String damageDice) {
    final regex = RegExp("^(\\d+)(d\\d{1,2})\$");
    final match = regex.firstMatch(damageDice);
    final amount = match?.group(1);
    Dice? dice;
    switch (match?.group(2)) {
      case "d4":
        dice = Dice.D4;
        break;
      case "d6":
        dice = Dice.D6;
        break;
      case "d8":
        dice = Dice.D8;
        break;
      case "d10":
        dice = Dice.D10;
        break;
      case "d12":
        dice = Dice.D12;
        break;
      case "d20":
        dice = Dice.D20;
        break;
      case "d100":
        dice = Dice.D100;
        break;
    }

    return DamageDice(
      int.parse(amount ?? "0"),
      dice ?? Dice.D4,
    );
  }

  Range? _rangeFromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return Range(
      json["normal"],
      json["long"],
    );
  }

  List<Property>? _propertiesFromJson(List<dynamic>? json) {
    return json
        ?.map((property) => (property["index"] as String?).toProperty())
        .where((element) => element != null)
        .map((e) => e!)
        .toList();
  }

  ThrowRange? _throwRangeFromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return ThrowRange(
      json["normal"] ?? 0,
      json["long"] ?? 0,
    );
  }

  ArmorClass _armorClassFromJson(Map<String, dynamic> json) {
    return ArmorClass(
      json["base"] ?? 0,
      json["dex_bonus"],
      json["max_bonus"],
    );
  }

  GearCategory? _gearCategoryFromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }
    final index = json["index"];
    switch (index) {
      case "standard-gear":
        return GearCategory.STANDARD_GEAR;
      case "holy-symbols":
        return GearCategory.HOLY_SYMBOLS;
      case "arcane-foci":
        return GearCategory.ACRANE_FOCI;
      case "druidic-foci":
        return GearCategory.DRUIDIC_FOCI;
      default:
        return null;
    }
  }

  List<String>? _descriptionFromJson(List<dynamic>? json) {
    return json?.map((e) => e as String).toList();
  }

  WeaponRange? _weaponRangeFromJson(String? json) {
    switch (json?.toLowerCase()) {
      case "melee":
        return WeaponRange.MELEE;
      case "ranged":
        return WeaponRange.RANGED;
      default:
        return null;
    }
  }
}
