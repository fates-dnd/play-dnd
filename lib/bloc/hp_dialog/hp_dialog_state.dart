part of 'hp_dialog_bloc.dart';

class HpDialogState extends Equatable {
  final int selectedAmount;

  const HpDialogState(this.selectedAmount);

  @override
  List<Object> get props => [selectedAmount];
}
