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
