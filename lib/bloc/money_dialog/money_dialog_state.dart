part of 'money_dialog_bloc.dart';

class MoneyDialogState extends Equatable {
  final int selectedValue;
  final Currency selectedCurrency;

  const MoneyDialogState({
    this.selectedValue = 0,
    this.selectedCurrency = Currency.COPPER,
  });

  @override
  List<Object> get props => [selectedValue, selectedCurrency];
}
