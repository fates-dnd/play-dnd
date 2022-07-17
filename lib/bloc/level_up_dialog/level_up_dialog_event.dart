part of 'level_up_dialog_bloc.dart';

abstract class LevelUpDialogEvent {}

class SetNewHp extends LevelUpDialogEvent {
  final int newHp;

  SetNewHp(this.newHp);
}
