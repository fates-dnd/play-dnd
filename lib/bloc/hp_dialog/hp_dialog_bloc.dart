import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hp_dialog_event.dart';
part 'hp_dialog_state.dart';

class HpDialogBloc extends Bloc<HpDialogEvent, HpDialogState> {
  HpDialogBloc() : super(HpDialogState(0)) {
    on<HpDialogEvent>((event, emit) {
      emit(HpDialogState(event.selectedAmount));
    });
  }
}
