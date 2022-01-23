import 'package:dnd_player_flutter/data/dice.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/feature.dart';

class LevelInfo {
  final int level;
  final int? abilityScoreBonuses;
  final int? proficiencyBonus;
  final List<Feature> features;
  final ClassSpecific? classSpecific;
  final Class clazz;

  LevelInfo(
    this.level,
    this.abilityScoreBonuses,
    this.proficiencyBonus,
    this.features,
    this.classSpecific,
    this.clazz,
  );
}

class ClassSpecific {
  // barbarian section
  final int? rageCount;
  final int? rageDamageBonus;
  final int? brutalCriticalDice;

  // bard section
  final Dice? bardicInspirationDie;
  final Dice? songOfRestDie;
  final int? magicalSecretsMax5;
  final int? magicalSecretsMax7;
  final int? magicalSecretsMax9;

  // cleric section
  final int? channelDivinityCharges;
  final double? destroryUndeadCR;

  // druid section
  final double? wildShapeMaxCR;
  final bool? wildShapeSwim;
  final bool? wildShapeFly;

  // fighter section
  final int? actionSurges;
  final int? indomitableUses;
  final int? extraAttacks;

  // monk section
  final MartialArts? martialArts;
  final int? kiPoints;
  final int? unarmoredMovement;

  // paladin section
  final int? auraRange;

  // range section
  final int? favoredEnemies;
  final int? favoredTerrain;

  // rogue section
  final SneakAttack? sneakAttack;

  // sorcerer section
  final int? sorceryPoints;
  final int? metamagicKnown;
  final List<SpellSlotPrice>? creatingSpellSlots;

  // warlock section
  final int? invocationsKnown;
  final int? mysticArcanumLevel6;
  final int? mysticArcanumLevel7;
  final int? mysticArcanumLevel8;
  final int? mysticArcanumLevel9;

  // wizard section
  final int? arcaneRecoveryLevels;

  ClassSpecific({
    this.rageCount,
    this.rageDamageBonus,
    this.brutalCriticalDice,
    this.bardicInspirationDie,
    this.songOfRestDie,
    this.magicalSecretsMax5,
    this.magicalSecretsMax7,
    this.magicalSecretsMax9,
    this.channelDivinityCharges,
    this.destroryUndeadCR,
    this.wildShapeMaxCR,
    this.wildShapeSwim,
    this.wildShapeFly,
    this.actionSurges,
    this.indomitableUses,
    this.extraAttacks,
    this.martialArts,
    this.kiPoints,
    this.unarmoredMovement,
    this.auraRange,
    this.favoredEnemies,
    this.favoredTerrain,
    this.sneakAttack,
    this.sorceryPoints,
    this.metamagicKnown,
    this.creatingSpellSlots,
    this.invocationsKnown,
    this.mysticArcanumLevel6,
    this.mysticArcanumLevel7,
    this.mysticArcanumLevel8,
    this.mysticArcanumLevel9,
    this.arcaneRecoveryLevels,
  });
}

class MartialArts {
  final Dice dice;
  final int amount;

  MartialArts(this.dice, this.amount);
}

class SneakAttack {
  final Dice dice;
  final int amount;

  SneakAttack(this.dice, this.amount);
}

class SpellSlotPrice {
  final int spellSlotLevel;
  final int sorceryPointSlot;

  SpellSlotPrice(this.spellSlotLevel, this.sorceryPointSlot);
}
