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
  final Equipment equipment;

  RemoveEquipmentItem(this.equipment);
}

class EquipItem extends CharacterEvent {
  final Equipment equipment;

  EquipItem(this.equipment);
}

class UnequipItem extends CharacterEvent {
  final Equipment equipment;

  UnequipItem(this.equipment);
}

class UpdateSpells extends CharacterEvent {
  final List<Spell> preparedSpells;
  final List<Spell> learnedSpells;

  UpdateSpells(this.preparedSpells, this.learnedSpells);
}
