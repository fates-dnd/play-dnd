part of 'stat_calculator_bloc.dart';

abstract class StatCalculatorEvent {}

class ApplyNumber extends StatCalculatorEvent {
  final int number;

  ApplyNumber(this.number);
}

class Backspace extends StatCalculatorEvent {}
