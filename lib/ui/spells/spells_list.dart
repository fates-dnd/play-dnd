import 'package:dnd_player_flutter/bloc/spells/spells_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:dnd_player_flutter/ui/spells/spell_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../search_app_bar.dart';

class SpellsList extends StatelessWidget {
  final Class? clazz;

  final List<Spell> preparedSpells;
  final List<Spell> learnedSpells;

  final Function(List<Spell> preparedSpells, List<Spell> learnedSpells)
      onSpellsUpdated;

  const SpellsList({
    Key? key,
    required this.clazz,
    required this.preparedSpells,
    required this.learnedSpells,
    required this.onSpellsUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpellsBloc(
        clazz,
        getIt<SettingsRepository>(),
        getIt<SpellsRepository>(),
        getIt<ClassesRepository>(),
        preparedSpells,
        learnedSpells,
      )..add(LoadSpells()),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: SearchAppBar(
              title: AppLocalizations.of(context)!.spells,
              onSearchValueChanged: (context, search) {
                BlocProvider.of<SpellsBloc>(context)
                    .add(SearchValueChanged(search));
              },
              onSearchCancelled: (context) {
                BlocProvider.of<SpellsBloc>(context).add(SearchCanceled());
              },
            )),
        body: BlocListener<SpellsBloc, SpellsState>(
          listener: (context, state) {
            onSpellsUpdated(state.preparedSpells, state.learnedSpells);
          },
          child: BlocBuilder<SpellsBloc, SpellsState>(
            builder: (context, state) {
              return ListView(
                children: state.spellDisplayItems
                    .map((spellDisplayItem) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 12),
                          child: _SpellListItem(
                              spellDisplayItem: spellDisplayItem),
                        ))
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SpellListItem extends StatelessWidget {
  final SpellDisplayItem spellDisplayItem;

  const _SpellListItem({Key? key, required this.spellDisplayItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    if (spellDisplayItem is FilterItem) {
      final filter = spellDisplayItem as FilterItem;
      return _FilterButton(
        clazz: filter.selectedOption,
        options: filter.options,
      );
    } else if (spellDisplayItem is PreparedSeparatorItem) {
      return Text(
        "Подготовленные заклинания",
        style: TextStyle(color: Color(0xFFDCDAD9), fontSize: 24),
      );
    } else if (spellDisplayItem is LearnedSeparatorItem) {
      return Text(
        "Изученные заклинания",
        style: TextStyle(color: Color(0xFFDCDAD9), fontSize: 24),
      );
    } else if (spellDisplayItem is LevelSeparatorItem) {
      final level = (spellDisplayItem as LevelSeparatorItem).level;
      return Text(
        level == 0
            ? localizations.cantrips
            : "${localizations.spell_level} $level",
        style: TextStyle(color: Color(0xFFDCDAD9), fontSize: 24),
      );
    } else if (spellDisplayItem is ActualSpellItem) {
      final actualSpellItem = (spellDisplayItem as ActualSpellItem);
      return SpellItem(
        spell: actualSpellItem.spell,
        onPrepareClick: !actualSpellItem.isPrepared
            ? () {
                BlocProvider.of<SpellsBloc>(context)
                    .add(PrepareSpell(actualSpellItem.spell));
              }
            : null,
        onUnprepareClick: actualSpellItem.isPrepared
            ? () {
                BlocProvider.of<SpellsBloc>(context)
                    .add(UnprepareSpell(actualSpellItem.spell));
              }
            : null,
      );
    }

    return SizedBox();
  }
}

class _FilterButton extends StatelessWidget {
  final Class? clazz;
  final List<Class?> options;

  const _FilterButton({
    Key? key,
    required this.clazz,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Ink(
            width: 200,
            decoration: BoxDecoration(
              color: Color(0xFF272E32),
              borderRadius: BorderRadius.circular(24),
            ),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Icon(
                        Icons.filter_list,
                        color: Color(0xFFFF5251),
                      ),
                    ),
                    Text(
                      clazz?.name ?? "",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
