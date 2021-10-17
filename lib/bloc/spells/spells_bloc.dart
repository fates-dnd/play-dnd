import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'spells_event.dart';
part 'spells_state.dart';

class SpellsBloc extends Bloc<SpellsEvent, SpellsState> {
  SpellsBloc() : super(SpellsInitial()) {
    on<SpellsEvent>((event, emit) {});
  }
}
