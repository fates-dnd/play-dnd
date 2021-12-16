import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:meta/meta.dart';

part 'spells_event.dart';
part 'spells_state.dart';

class SpellsBloc extends Bloc<SpellsEvent, SpellsState> {
  final Class? clazz;
  final SettingsRepository settingsRepository;
  final SpellsRepository spellsRepository;

  final List<Spell> preparedSpells;
  final List<Spell> learnedSpells;

  List<Spell> allAvailableSpells = [];

  String? searchValue;

  SpellsBloc(
    this.clazz,
    this.settingsRepository,
    this.spellsRepository,
    this.preparedSpells,
    this.learnedSpells,
  ) : super(SpellsState(preparedSpells, learnedSpells, [])) {
    on<SpellsEvent>((event, emit) async {
      if (event is LoadSpells) {
        final spellDisplayItems = await loadSpells();
        emit.call(
            SpellsState(preparedSpells, learnedSpells, spellDisplayItems));
      } else if (event is PrepareSpell) {
        if (preparedSpells
            .any((element) => element.index == event.spell.index)) {
          return;
        }
        preparedSpells.add(event.spell);
        emit.call(SpellsState(preparedSpells, learnedSpells,
            searchCompletedSpellDisplayItem(searchValue)));
      } else if (event is UnprepareSpell) {
        preparedSpells
            .removeWhere((element) => element.index == event.spell.index);
        emit.call(SpellsState(preparedSpells, learnedSpells,
            searchCompletedSpellDisplayItem(searchValue)));
      } else if (event is LearnSpell) {
        if (learnedSpells
            .any((element) => element.index == event.spell.index)) {
          return;
        }
        learnedSpells.add(event.spell);
        emit.call(SpellsState(preparedSpells, learnedSpells,
            searchCompletedSpellDisplayItem(searchValue)));
      } else if (event is UnlearnSpell) {
        preparedSpells
            .removeWhere((element) => element.index == event.spell.index);
        learnedSpells
            .removeWhere((element) => element.index == event.spell.index);
        emit.call(SpellsState(preparedSpells, learnedSpells,
            searchCompletedSpellDisplayItem(searchValue)));
      } else if (event is SearchValueChanged) {
        searchValue = event.searchValue;
        emit.call(SpellsState(preparedSpells, learnedSpells,
            searchCompletedSpellDisplayItem(event.searchValue)));
      } else if (event is SearchCanceled) {
        searchValue = null;
        emit.call(SpellsState(preparedSpells, learnedSpells,
            searchCompletedSpellDisplayItem(searchValue)));
      }
    });
  }

  Future<List<SpellDisplayItem>> loadSpells() async {
    final language = settingsRepository.getLanguage();
    final spells = await spellsRepository.getSpells(language);
    spells.sort((left, right) => left.level.compareTo(right.level));
    allAvailableSpells = spells
        .where((element) => element.classesIds.contains(clazz?.index))
        .toList();

    return searchCompletedSpellDisplayItem(searchValue);
  }

  List<SpellDisplayItem> searchCompletedSpellDisplayItem(String? searchValue) {
    final lowercaseSearchValue = searchValue?.toLowerCase();

    final result = <SpellDisplayItem>[];
    final foundPreparedSpells = preparedSpells.where((element) {
      if (lowercaseSearchValue == null) {
        return true;
      }

      return element.index.contains(lowercaseSearchValue) ||
          element.name.toLowerCase().contains(lowercaseSearchValue);
    });
    final foundLearnedSpells = learnedSpells.where((element) {
      if (lowercaseSearchValue == null) {
        return true;
      }

      return element.index.contains(lowercaseSearchValue) ||
          element.name.toLowerCase().contains(lowercaseSearchValue);
    });
    final foundSpells = allAvailableSpells.where((element) {
      if (lowercaseSearchValue == null) {
        return true;
      }

      return element.index.contains(lowercaseSearchValue) ||
          element.name.contains(lowercaseSearchValue);
    });
    if (foundPreparedSpells.isNotEmpty) {
      result.add(PreparedSeparatorItem());
      foundPreparedSpells.forEach((spell) {
        final isLearned =
            learnedSpells.any((element) => element.index == spell.index);
        result.add(ActualSpellItem(spell, true, isLearned));
      });
    }

    if (foundLearnedSpells.isNotEmpty) {
      result.add(LearnedSeparatorItem());
      foundLearnedSpells.forEach((spell) {
        final isPrepared =
            preparedSpells.any((element) => element.index == spell.index);
        result.add(ActualSpellItem(spell, isPrepared, true));
      });
    }

    if (foundSpells.isNotEmpty) {
      var currentLevel = 0;
      result.add(LevelSeparatorItem(currentLevel));
      foundSpells.forEach((spell) {
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
