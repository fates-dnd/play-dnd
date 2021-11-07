part of 'spells_bloc.dart';

class SpellsState {
  final List<SpellDisplayItem> spellDisplayItems;

  SpellsState(this.spellDisplayItems);
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

  ActualSpellItem(this.spell);
}
