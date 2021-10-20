import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnd_player_flutter/utils.dart';

class SpellsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(padding: EdgeInsets.only(top: 8)),
        SpellcastingInfoRow(),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SizedBox();
            }));
          },
          child: Text("Добавить"),
        ),
      ],
    );
  }
}

class SpellcastingInfoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
              color: theme.primaryColorLight,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SpellcastingInfoItem(
                  modifier: state.spellcastingModifier?.toBonusString() ?? "",
                  description: "модификатор"),
              SpellcastingInfoItem(
                  modifier: state.spellcastingAttack?.toBonusString() ?? "",
                  description: "атака"),
              SpellcastingInfoItem(
                  modifier: state.spellSavingThrow.toString(),
                  description: "спас бросок"),
            ],
          ),
        );
      },
    );
  }
}

class SpellcastingInfoItem extends StatelessWidget {
  final String modifier;
  final String description;

  const SpellcastingInfoItem(
      {Key? key, required this.modifier, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          modifier,
          style: TextStyle(fontSize: 32),
        ),
        Text(
          description,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
