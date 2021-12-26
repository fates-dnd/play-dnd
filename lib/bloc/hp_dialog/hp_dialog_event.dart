part of 'hp_dialog_bloc.dart';

class HpDialogEvent extends Equatable {
  final int selectedAmount;

  const HpDialogEvent(this.selectedAmount);

  @override
  List<Object> get props => [selectedAmount];
}
