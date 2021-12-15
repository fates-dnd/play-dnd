part of 'equipment_bloc.dart';

@immutable
abstract class EquipmentEvent {}

class LoadEquipment extends EquipmentEvent {}

class SearchValueChanged extends EquipmentEvent {
  final String searchValue;

  SearchValueChanged(this.searchValue);
}

class SearchCancelled extends EquipmentEvent {}
