import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/currency.dart';
import 'package:equatable/equatable.dart';

part 'money_dialog_event.dart';
part 'money_dialog_state.dart';

class MoneyDialogBloc extends Bloc<MoneyDialogEvent, MoneyDialogState> {
  MoneyDialogBloc() : super(MoneyDialogState()) {
    on<MoneyDialogEvent>((event, emit) {
      if (event is LoadMoneyData) {
      } else if (event is ChangeMoneyValue) {
        emit(MoneyDialogState(
          selectedValue: event.value,
          selectedCurrency: state.selectedCurrency,
        ));
      } else if (event is ChangeCurrency) {
        emit(MoneyDialogState(
          selectedValue: state.selectedValue,
          selectedCurrency: event.currency,
        ));
      }
    });
  }
}
