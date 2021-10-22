import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:meta/meta.dart';

part 'spells_event.dart';
part 'spells_state.dart';

class SpellsBloc extends Bloc<SpellsEvent, SpellsState> {
  final SpellsRepository repository;

  SpellsBloc(this.repository) : super(SpellsState([])) {
    on<SpellsEvent>((event, emit) async {
      if (event is LoadSpells) {
        final spells = await repository.getSpells();
        emit.call(SpellsState(spells));
      }
    });
  }
}
