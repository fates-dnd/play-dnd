part of 'characteristics_bonus_bloc.dart';

@immutable
abstract class CharacteristicsBonusEvent {}

class SelectBonusCharacteristic extends CharacteristicsBonusEvent {
  final int position;
  final Characteristic characteristic;

  SelectBonusCharacteristic(this.position, this.characteristic);
}
