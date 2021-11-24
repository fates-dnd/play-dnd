import 'package:flutter_bloc/flutter_bloc.dart';

part 'stat_calculator_event.dart';
part 'stat_calculator_state.dart';

class StatCalculatorBloc
    extends Bloc<StatCalculatorEvent, StatCalculatorState> {
  StatCalculatorBloc(StatCalculatorState initialState) : super(initialState) {
    on((event, emit) {
      if (event is ApplyNumberEvent) {
        final newEnteredValue =
            int.parse("${state.enteredValue}${event.number}");

        emit(StatCalculatorState(
          newEnteredValue,
          state.bonus,
          newEnteredValue + state.bonus,
        ));
      }
    });
  }
}
