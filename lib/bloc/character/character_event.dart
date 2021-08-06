part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class SetCharacter extends CharacterEvent {
  final Character character;

  SetCharacter(this.character);
}

class SelectEquipmentItem extends CharacterEvent {
  final Equipment equipment;

  SelectEquipmentItem(this.equipment);
}

class RemoveEquipmentItem extends CharacterEvent {
  final Equipment equipment;

  RemoveEquipmentItem(this.equipment);
}
