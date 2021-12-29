part of 'money_dialog_bloc.dart';

abstract class MoneyDialogEvent extends Equatable {
  const MoneyDialogEvent();
}

class LoadMoneyData extends MoneyDialogEvent {
  @override
  List<Object?> get props => [];
}

class ChangeMoneyValue extends MoneyDialogEvent {
  final int value;

  ChangeMoneyValue(this.value);

  @override
  List<Object?> get props => [value];
}

class ChangeCurrency extends MoneyDialogEvent {
  final Currency currency;

  ChangeCurrency(this.currency);

  @override
  List<Object?> get props => [currency];
}
