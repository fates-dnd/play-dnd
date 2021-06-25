part of 'set_characteristics_bloc.dart';

class SetCharacteristicsState {
  final int? level;
  final int? strength;
  final int? dexterity;
  final int? constitution;
  final int? intelligence;
  final int? wisdom;
  final int? charisma;

  SetCharacteristicsState(
      {this.level,
      this.strength,
      this.dexterity,
      this.constitution,
      this.intelligence,
      this.wisdom,
      this.charisma});

  int? getScoreForCharacteristic(Characteristic characteristic) {
    switch (characteristic) {
      case Characteristic.STRENGTH:
        return strength;
      case Characteristic.DEXTERITY:
        return dexterity;
      case Characteristic.CONSTITUTION:
        return constitution;
      case Characteristic.INTELLECT:
        return intelligence;
      case Characteristic.WISDOM:
        return wisdom;
      case Characteristic.CHARISMA:
        return charisma;
    }
  }
}
