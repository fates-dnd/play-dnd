import 'package:dnd_player_flutter/bloc/spells/spells_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:dnd_player_flutter/ui/spells/spell_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpellsList extends StatelessWidget {
  final Class? clazz;

  final List<Spell>? preparedSpells;
  final List<Spell>? learnedSpells;

  const SpellsList({
    Key? key,
    required this.clazz,
    this.preparedSpells,
    this.learnedSpells,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpellsBloc(
        clazz,
        getIt<SpellsRepository>(),
        preparedSpells ?? [],
        learnedSpells ?? [],
      )..add(LoadSpells()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Заклинания"),
        ),
        body: BlocBuilder<SpellsBloc, SpellsState>(
          builder: (context, state) {
            return ListView(
              children: state.spellDisplayItems
                  .map((spellDisplayItem) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 12),
                        child:
                            _SpellListItem(spellDisplayItem: spellDisplayItem),
                      ))
                  .toList(),
            );
          },
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
    if (spellDisplayItem is PreparedSeparatorItem) {
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
      return Text(
        "Круг " + (spellDisplayItem as LevelSeparatorItem).level.toString(),
        style: TextStyle(color: Color(0xFFDCDAD9), fontSize: 24),
      );
    } else if (spellDisplayItem is ActualSpellItem) {
      final actualSpellItem = (spellDisplayItem as ActualSpellItem);
      return SpellItem(
        spell: actualSpellItem.spell,
        isPrepared: actualSpellItem.isPrepared,
      );
    }

    return SizedBox();
  }
}
