import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/rules/spellcasting/bard_spellcasting.dart';
import 'package:dnd_player_flutter/rules/spellcasting/cleric_spellcasting.dart';
import 'package:dnd_player_flutter/rules/spellcasting/druid_spellcasting.dart';
import 'package:dnd_player_flutter/rules/spellcasting/paladin_spellcasting.dart';
import 'package:dnd_player_flutter/rules/spellcasting/ranger_spellcasting.dart';
import 'package:dnd_player_flutter/rules/spellcasting/sorcerer_spellcasting.dart';
import 'package:dnd_player_flutter/rules/spellcasting/warlock_spellcasting.dart';
import 'package:dnd_player_flutter/rules/spellcasting/wizard_spellcasting.dart';

abstract class Spellcasting {
  Map<int, Map<int, int>> get spellSlotsPerLevel;

  Map<int, int>? getSpellSlotsForLevel(int level) {
    return spellSlotsPerLevel[level];
  }

  static Spellcasting? createForClass(Class clazz) {
    switch (clazz.index) {
      case "bard":
        return BardSpellcasting();
      case "cleric":
        return ClericSpellcasting();
      case "druid":
        return DruidSpellcasting();
      case "paladin":
        return PaladinSpellcasting();
      case "ranger":
        return RangerSpellcasting();
      case "sorcerer":
        return SorcererSpellcasting();
      case "warlock":
        return WarlockSpellcasting();
      case "wizard":
        return WizardSpellcasting();
    }

    // no spellcasting for this class
    return null;
  }
}
