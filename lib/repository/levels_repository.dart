import 'dart:convert';

import 'package:dnd_player_flutter/data/dice.dart';
import 'package:dnd_player_flutter/dto/level_info.dart';

class LevelsRepository {
  final Future<String> Function(String lang) jsonReader;

  List<LevelInfo>? loadedLevels;
  String? language;

  LevelsRepository(
    this.jsonReader,
  );

  Future<List<LevelInfo>> getLevels(String language) async {
    if (this.language == language && loadedLevels != null) {
      return loadedLevels!;
    }

    final response = await jsonReader(language);
    final List<dynamic> levelsJson = json.decode(response);
    return levelsJson.map((e) => _fromJson(e)).toList();
  }

  LevelInfo _fromJson(Map<String, dynamic> json) {
    return LevelInfo(
      json["level"],
      json["ability_score_bonuses"],
      json["prof_bonus"],
      (json["features"] as List<dynamic>)
          .map((e) => e["index"] as String)
          .toList(),
      _parseClassSpecific(json["class_specific"]),
      json["class"]["index"],
    );
  }

  ClassSpecific? _parseClassSpecific(Map<String, dynamic>? classSpecific) {
    if (classSpecific == null) {
      return null;
    }

    return ClassSpecific(
      rageCount: classSpecific["rage_count"],
      rageDamageBonus: classSpecific["rage_damage_bonus"],
      brutalCriticalDice: classSpecific["brutal_critical_dice"],
      bardicInspirationDie: _parseDie(classSpecific["bardic_inspiration_die"]),
      songOfRestDie: _parseDie(classSpecific["song_of_rest_die"]),
      magicalSecretsMax5: classSpecific["magical_secrets_max_5"],
      magicalSecretsMax7: classSpecific["magical_secrets_max_7"],
      magicalSecretsMax9: classSpecific["magical_secrets_max_9"],
      channelDivinityCharges: classSpecific["channel_divinity_charges"],
      destroryUndeadCR: classSpecific["destroy_undead_cr"]?.toDouble(),
      wildShapeMaxCR: classSpecific["wild_shape_max_cr"]?.toDouble(),
      wildShapeSwim: classSpecific["wild_shape_swim"],
      wildShapeFly: classSpecific["wild_shape_fly"],
      actionSurges: classSpecific["action_surges"],
      indomitableUses: classSpecific["indomitable_uses"],
      extraAttacks: classSpecific["extra_attacks"],
      martialArts: _parseMartialDice(classSpecific["martial_arts"]),
      kiPoints: classSpecific["ki_points"],
      unarmoredMovement: classSpecific["unarmored_movement"],
      auraRange: classSpecific["aura_range"],
      favoredEnemies: classSpecific["favored_enemies"],
      favoredTerrain: classSpecific["favored_terrain"],
      sneakAttack: _parseSneakAttack(classSpecific["sneak_attack"]),
      sorceryPoints: classSpecific["sorcery_points"],
      metamagicKnown: classSpecific["metamagic_known"],
      creatingSpellSlots:
          _parseSpellSlotPrice(classSpecific["creating_spell_slots"]),
      invocationsKnown: classSpecific["invocations_known"],
      mysticArcanumLevel6: classSpecific["mystic_arcanum_level_6"],
      mysticArcanumLevel7: classSpecific["mystic_arcanum_level_7"],
      mysticArcanumLevel8: classSpecific["mystic_arcanum_level_8"],
      mysticArcanumLevel9: classSpecific["mystic_arcanum_level_9"],
      arcaneRecoveryLevels: classSpecific["arcane_recovery_levels"],
    );
  }

  MartialArts? _parseMartialDice(Map<String, dynamic>? martialArts) {
    final dice = _parseDie(martialArts?["dice_count"]);
    final value = martialArts?["dice_value"];
    if (dice == null || value == null) {
      return null;
    }
    return MartialArts(dice, value);
  }

  SneakAttack? _parseSneakAttack(Map<String, dynamic>? sneakAttack) {
    final dice = _parseDie(sneakAttack?["dice_count"]);
    final value = sneakAttack?["dice_value"];
    if (dice == null || value == null) {
      return null;
    }

    return SneakAttack(dice, value);
  }

  List<SpellSlotPrice>? _parseSpellSlotPrice(List<dynamic>? spellSlotPrices) {
    return spellSlotPrices
        ?.map((e) => SpellSlotPrice(
              e["spell_slot_level"],
              e["sorcery_point_cost"],
            ))
        .toList();
  }

  Dice? _parseDie(int? diceValue) {
    switch (diceValue) {
      case 4:
        return Dice.D4;
      case 6:
        return Dice.D6;
      case 8:
        return Dice.D8;
      case 10:
        return Dice.D10;
      case 12:
        return Dice.D12;
      case 20:
        return Dice.D20;
      case 100:
        return Dice.D100;
    }
    return null;
  }
}
