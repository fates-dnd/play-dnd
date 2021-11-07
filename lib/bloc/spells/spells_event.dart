part of 'spells_bloc.dart';

@immutable
abstract class SpellsEvent {}

class LoadSpells extends SpellsEvent {}

class PrepareSpell extends SpellsEvent {
  final Spell spell;

  PrepareSpell(this.spell);
}

class UnprepareSpell extends SpellsEvent {
  final Spell spell;

  UnprepareSpell(this.spell);
}

class LearnSpell extends SpellsEvent {
  final Spell spell;

  LearnSpell(this.spell);
}

class UnlearnSpell extends SpellsEvent {
  final Spell spell;

  UnlearnSpell(this.spell);
}
