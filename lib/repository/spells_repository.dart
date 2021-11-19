import 'dart:convert';

import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/mappers.dart';
import 'package:dnd_player_flutter/repository/parse_damage_type.dart';

class SpellsRepository {
  final Future<String> Function(String lang) jsonReader;

  SpellsRepository(this.jsonReader);

  Future<List<Spell>> getSpells(String language) async {
    final response = await jsonReader(language);
    final List<dynamic> spellsJson = json.decode(response);
    return spellsJson.map((item) => _fromJson(item)).toList();
  }

  Spell _fromJson(Map<String, dynamic> json) {
    return Spell(
      json["index"],
      json["name"],
      json["desc"].cast<String>(),
      json["range"],
      _parseComponents(json["components"].cast<String>()),
      json["material"],
      json["ritual"],
      json["duration"],
      json["concentration"],
      json["casting_time"],
      json["level"],
      json["heal_at_slot_level"]?.cast<String, String>(),
      _parseDamage(json["damage"]),
      _parseDc(json["dc"]),
      _parseSchool(json["school"]),
      _parseClassesIds(json["classes"].cast<Map<String, dynamic>>()),
    );
  }

  List<Component> _parseComponents(List<String> components) {
    return components.map((component) {
      switch (component) {
        case "M":
          return Component.MATERIAL;
        case "V":
          return Component.VERBAL;
        case "S":
          return Component.SOMATIC;
        default:
          throw ArgumentError("No such component $component");
      }
    }).toList();
  }

  Damage? _parseDamage(Map<String, dynamic>? damage) {
    if (damage == null) {
      return null;
    }

    return Damage(
      parseDamageType(damage["damage_type"]),
      damage["damage_at_character_level"]?.cast<String, String>(),
      damage["damage_at_slot_level"]?.cast<String, String>(),
    );
  }

  Dc? _parseDc(Map<String, dynamic>? dc) {
    if (dc == null) {
      return null;
    }

    return Dc(
      indexAsCharacteristic(dc["dc_type"]["index"]),
      _parseDcSuccess(dc["dc_success"]),
      dc["desc"],
    );
  }

  DcSuccess _parseDcSuccess(String dcSuccess) {
    switch (dcSuccess) {
      case "other":
        return DcSuccess.OTHER;
      case "half":
        return DcSuccess.HALF;
      case "none":
        return DcSuccess.NONE;
      default:
        throw ArgumentError("$dcSuccess is not a success type");
    }
  }

  School _parseSchool(Map<String, dynamic> json) {
    final index = json["index"];
    switch (index) {
      case "enchantment":
        return School.ENCHANTMENT;
      case "abjuration":
        return School.ABJURATION;
      case "transmutation":
        return School.TRANSMUTATION;
      case "necromancy":
        return School.NECROMANCY;
      case "evocation":
        return School.EVOCATION;
      case "illusion":
        return School.ILLUSION;
      case "conjuration":
        return School.CONJURATION;
      case "divination":
        return School.DIVINATION;
      default:
        throw ArgumentError("$index is not a magic school");
    }
  }

  List<String> _parseClassesIds(List<Map<String, dynamic>> json) {
    return json.map((el) => el["index"] as String).toList();
  }
}
