import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ManageAbilityScoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(localizations.manage_ability_scores),
        ),
        body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: Characteristic.values
                .map((characteristic) => _CharacteristicRow(
                      characteristic: characteristic,
                      value: _getCharacteristicStat(characteristic, state),
                      bonus: 0,
                    ))
                .toList()),
      ),
    );
  }

  int _getCharacteristicStat(
      Characteristic characteristic, CharacterState state) {
    switch (characteristic) {
      case Characteristic.STRENGTH:
        return state.strength;
      case Characteristic.DEXTERITY:
        return state.dexterity;
      case Characteristic.CONSTITUTION:
        return state.constitution;
      case Characteristic.INTELLIGENCE:
        return state.intelligence;
      case Characteristic.WISDOM:
        return state.wisdom;
      case Characteristic.CHARISMA:
        return state.charisma;
    }
  }
}

class _CharacteristicRow extends StatelessWidget {
  final Characteristic characteristic;
  final int value;
  final int bonus;

  const _CharacteristicRow({
    Key? key,
    required this.characteristic,
    required this.value,
    required this.bonus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
                child: Text(
              characteristic.getName(context),
              style: TextStyle(fontSize: 18),
            )),
            Text(
              value.toString(),
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
