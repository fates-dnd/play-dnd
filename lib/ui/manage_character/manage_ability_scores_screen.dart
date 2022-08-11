import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/bloc/manage_ability_scores/manage_ability_scores_bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/ui/stat_calculator/stat_calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ManageAbilityScoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => ManageAbilityScoresBloc(),
      child: BlocBuilder<CharacterBloc, CharacterState>(
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
                        bonus: state.getRaceAbilityBonus(characteristic),
                      ))
                  .toList()),
        ),
      ),
    );
  }

  int _getCharacteristicStat(
      Characteristic characteristic, CharacterState state) {
    switch (characteristic) {
      case Characteristic.STRENGTH:
        return state.totalStrength;
      case Characteristic.DEXTERITY:
        return state.totalDexterity;
      case Characteristic.CONSTITUTION:
        return state.totalConstitution;
      case Characteristic.INTELLIGENCE:
        return state.totalIntelligence;
      case Characteristic.WISDOM:
        return state.totalWisdom;
      case Characteristic.CHARISMA:
        return state.totalCharisma;
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
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StatCalculatorScreen(
                abilityBonus: AbilityBonus(characteristic, bonus),
                onSubmit: (newValue) {
                  BlocProvider.of<ManageAbilityScoresBloc>(context)
                      .add(ManageAbilityScoresEvent(characteristic, newValue));
                })));
      },
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
