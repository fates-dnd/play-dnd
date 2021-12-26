part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class SetCharacter extends CharacterEvent {
  final Character character;

  SetCharacter(this.character);
}

class AddEquipmentItem extends CharacterEvent {
  final Equipment equipment;

  AddEquipmentItem(this.equipment);
}

class RemoveEquipmentItem extends CharacterEvent {
  final EquipmentQuantity equipment;

  RemoveEquipmentItem(this.equipment);
}

class EquipItem extends CharacterEvent {
  final EquipmentQuantity equipment;

  EquipItem(this.equipment);
}

class UnequipItem extends CharacterEvent {
  final EquipmentQuantity equipment;

  UnequipItem(this.equipment);
}

class UpdateSpells extends CharacterEvent {
  final List<Spell> preparedSpells;
  final List<Spell> learnedSpells;

  UpdateSpells(this.preparedSpells, this.learnedSpells);
}

class UseSpellSlot extends CharacterEvent {
  final int spellLevel;

  UseSpellSlot(this.spellLevel);
}

class UnuseSpellSlot extends CharacterEvent {
  final int spellLevel;

  UnuseSpellSlot(this.spellLevel);
}

class Heal extends CharacterEvent {
  final int amount;

  Heal(this.amount);
}

class Damage extends CharacterEvent {
  final int amount;

  Damage(this.amount);
}
