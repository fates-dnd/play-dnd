part of 'stat_calculator_bloc.dart';

abstract class StatCalculatorEvent {}

class ApplyNumberEvent extends StatCalculatorEvent {
  final int number;

  ApplyNumberEvent(this.number);
}

class RemoveLastNumber extends StatCalculatorEvent {}
