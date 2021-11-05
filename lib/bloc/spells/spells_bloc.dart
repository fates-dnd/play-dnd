import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:meta/meta.dart';

part 'spells_event.dart';
part 'spells_state.dart';

class SpellsBloc extends Bloc<SpellsEvent, SpellsState> {
  final Class? clazz;
  final SpellsRepository repository;

  SpellsBloc(this.clazz, this.repository) : super(SpellsState([])) {
    on<SpellsEvent>((event, emit) async {
      if (event is LoadSpells) {
        final spells = await repository.getSpells();
        spells.sort((left, right) => left.level.compareTo(right.level));
        final filteredSpells = spells
            .where((element) => element.classesIds.contains(clazz?.index));

        if (filteredSpells.isEmpty) {
          return;
        }

        List<SpellDisplayItem> result = [];

        var currentLevel = 0;
        result.add(LevelSeparatorItem(currentLevel));
        for (var i = 0; i < filteredSpells.length; ++i) {
          final spell = spells[i];
          if (spell.level != currentLevel) {
            currentLevel = spell.level;
            result.add(LevelSeparatorItem(currentLevel));
          }

          result.add(ActualSpellItem(spell));
        }

        emit.call(SpellsState(result));
      }
    });
  }
}
