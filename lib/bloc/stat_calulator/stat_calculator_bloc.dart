import 'package:flutter_bloc/flutter_bloc.dart';

part 'stat_calculator_event.dart';
part 'stat_calculator_state.dart';

class StatCalculatorBloc
    extends Bloc<StatCalculatorEvent, StatCalculatorState> {
  StatCalculatorBloc(StatCalculatorState initialState) : super(initialState) {
    on((event, emit) {
      if (event is ApplyNumber) {
        final newEnteredValue =
            int.parse("${state.enteredValue}${event.number}");

        emit(StatCalculatorState(
          newEnteredValue,
          state.bonus,
          newEnteredValue + state.bonus,
          _evaluateError(),
        ));
      } else if (event is Backspace) {
        final stringEnteredValue = state.enteredValue.toString();
        int newEnteredValue = 0;
        if (stringEnteredValue.length > 1) {
          newEnteredValue = int.parse(
              stringEnteredValue.substring(0, stringEnteredValue.length - 1));
        }

        emit(StatCalculatorState(
          newEnteredValue,
          state.bonus,
          newEnteredValue + state.bonus,
          _evaluateError(),
        ));
      }
    });
  }

  StatCalculatorError _evaluateError() {
    if (state.enteredValue < 3) {
      return StatCalculatorError.MINIMUM_VALUE_IS_3;
    }
    if (state.enteredValue > 18) {
      return StatCalculatorError.MAXIMUM_VALUE_IS_18;
    }
    return StatCalculatorError.NONE;
  }
}
