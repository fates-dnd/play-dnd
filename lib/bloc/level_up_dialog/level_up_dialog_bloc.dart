import 'package:flutter_bloc/flutter_bloc.dart';

part 'level_up_dialog_event.dart';
part 'level_up_dialog_state.dart';

class LevelUpDialogBloc extends Bloc<LevelUpDialogEvent, LevelUpDialogState> {
  LevelUpDialogBloc() : super(LevelUpDialogState(0)) {
    on((event, emit) {
      if (event is SetNewHp) {
        emit(LevelUpDialogState(event.newHp));
      }
    });
  }
}
