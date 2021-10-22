import 'dart:convert';

import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/mappers.dart';

class SpellsRepository {
  final Future<String> Function() jsonReader;

  SpellsRepository(this.jsonReader);

  Future<List<Spell>> getSpells() async {
    final response = await jsonReader();
    final List<dynamic> spellsJson = json.decode(response);
    return spellsJson.map((item) => _fromJson(item)).toList();
  }

  Spell _fromJson(Map<String, dynamic> json) {
    return Spell(
      json["index"],
      json["name"],
      json["desc"],
      json["range"],
      _parseComponents(json["components"]),
      json["material"],
      json["ritual"],
      json["duration"],
      json["concentration"],
      json["casting_time"],
      json["level"],
      _parseDamage(json["damage"]),
      _parseDc(json["dc"]),
      _parseSchool(json["school"]),
      _parseClassesIds(json["classes"]),
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

  Damage _parseDamage(Map<String, dynamic> damage) {
    return Damage(
      _parseDamageType(damage["damage_type"]),
      damage["damage_at_character_level"],
      damage["damage_at_slot_level"],
    );
  }

  DamageType _parseDamageType(Map<String, dynamic> damageType) {
    final index = damageType["index"];
    switch (index) {
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
        throw ArgumentError("$index is not a damage type.");
    }
  }

  Dc _parseDc(Map<String, dynamic> dc) {
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
