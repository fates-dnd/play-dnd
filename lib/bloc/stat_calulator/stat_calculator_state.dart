part of 'stat_calculator_bloc.dart';

class StatCalculatorState {
  final int enteredValue;
  final int bonus;
  final int result;
  final StatCalculatorError error;

  StatCalculatorState(
    this.enteredValue,
    this.bonus,
    this.result,
    this.error,
  );
}

enum StatCalculatorError {
  MINIMUM_VALUE_IS_3,
  MAXIMUM_VALUE_IS_18,
  NONE,
}
