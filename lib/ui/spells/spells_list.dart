import 'package:dnd_player_flutter/bloc/spells/spells_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpellsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpellsBloc(),
      child: Scaffold(
        body: ListView(
          children: [],
        ),
      ),
    );
  }
}
