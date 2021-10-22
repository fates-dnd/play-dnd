import 'package:dnd_player_flutter/bloc/spells/spells_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:dnd_player_flutter/ui/spells/spell_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpellsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SpellsBloc(getIt<SpellsRepository>())..add(LoadSpells()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Заклинания"),
        ),
        body: BlocBuilder<SpellsBloc, SpellsState>(
          builder: (context, state) {
            return ListView(
              children:
                  state.spells.map((spell) => SpellItem(spell: spell)).toList(),
            );
          },
        ),
      ),
    );
  }
}
