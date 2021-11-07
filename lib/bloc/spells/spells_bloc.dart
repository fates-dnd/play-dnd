import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:meta/meta.dart';

part 'spells_event.dart';
part 'spells_state.dart';

class SpellsBloc extends Bloc<SpellsEvent, SpellsState> {
  final Class? clazz;
  final SpellsRepository spellsRepository;

  final List<Spell> preparedSpells;
  final List<Spell> learnedSpells;

  List<Spell> allAvailableSpells = [];

  SpellsBloc(
    this.clazz,
    this.spellsRepository,
    this.preparedSpells,
    this.learnedSpells,
  ) : super(SpellsState([])) {
    on<SpellsEvent>((event, emit) async {
      if (event is LoadSpells) {
        final spellDisplayItems = await loadSpells();
        emit.call(SpellsState(spellDisplayItems));
      } else if (event is PrepareSpell) {
        if (preparedSpells
            .any((element) => element.index == event.spell.index)) {
          return;
        }
        preparedSpells.add(event.spell);
        emit.call(SpellsState(getCompletedSpellDisplayItem()));
      } else if (event is UnprepareSpell) {
        preparedSpells
            .removeWhere((element) => element.index == event.spell.index);
        emit.call(SpellsState(getCompletedSpellDisplayItem()));
      } else if (event is LearnSpell) {
        if (learnedSpells
            .any((element) => element.index == event.spell.index)) {
          return;
        }
        learnedSpells.add(event.spell);
        emit.call(SpellsState(getCompletedSpellDisplayItem()));
      } else if (event is UnlearnSpell) {
        preparedSpells
            .removeWhere((element) => element.index == event.spell.index);
        learnedSpells
            .removeWhere((element) => element.index == event.spell.index);
        emit.call(SpellsState(getCompletedSpellDisplayItem()));
      }
    });
  }

  Future<List<SpellDisplayItem>> loadSpells() async {
    final spells = await spellsRepository.getSpells();
    spells.sort((left, right) => left.level.compareTo(right.level));
    allAvailableSpells = spells
        .where((element) => element.classesIds.contains(clazz?.index))
        .toList();

    return getCompletedSpellDisplayItem();
  }

  List<SpellDisplayItem> getCompletedSpellDisplayItem() {
    final result = <SpellDisplayItem>[];
    if (preparedSpells.isNotEmpty) {
      result.add(PreparedSeparatorItem());
      preparedSpells.forEach((spell) {
        final isLearned =
            learnedSpells.any((element) => element.index == spell.index);
        result.add(ActualSpellItem(spell, true, isLearned));
      });
    }

    if (learnedSpells.isNotEmpty) {
      result.add(LearnedSeparatorItem());
      learnedSpells.forEach((spell) {
        final isPrepared =
            preparedSpells.any((element) => element.index == spell.index);
        result.add(ActualSpellItem(spell, isPrepared, true));
      });
    }

    if (allAvailableSpells.isNotEmpty) {
      var currentLevel = 0;
      result.add(LevelSeparatorItem(currentLevel));
      allAvailableSpells.forEach((spell) {
        if (spell.level != currentLevel) {
          currentLevel = spell.level;
          result.add(LevelSeparatorItem(currentLevel));
        }

        final isPrepared =
            preparedSpells.any((element) => element.index == spell.index);
        final isLearned =
            learnedSpells.any((element) => element.index == spell.index);
        result.add(ActualSpellItem(spell, isPrepared, isLearned));
      });
    }

    return result;
  }
}
