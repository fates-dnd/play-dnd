part of 'spells_bloc.dart';

class SpellsState {
  final List<Spell> preparedSpells;
  final List<Spell> learnedSpells;

  final List<SpellDisplayItem> spellDisplayItems;

  SpellsState(this.preparedSpells, this.learnedSpells, this.spellDisplayItems);
}

abstract class SpellDisplayItem {}

class PreparedSeparatorItem extends SpellDisplayItem {}

class LearnedSeparatorItem extends SpellDisplayItem {}

class LevelSeparatorItem extends SpellDisplayItem {
  final int level;

  LevelSeparatorItem(this.level);
}

class ActualSpellItem extends SpellDisplayItem {
  final Spell spell;
  final bool isPrepared;
  final bool? isLearned;

  ActualSpellItem(
    this.spell,
    this.isPrepared,
    this.isLearned,
  );
}
