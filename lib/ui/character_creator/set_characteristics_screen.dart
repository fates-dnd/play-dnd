import 'package:dnd_player_flutter/bloc/character_creator/character_creator/character_creator_bloc.dart';
import 'package:dnd_player_flutter/bloc/character_creator/set_characteristics/set_characteristics_bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/ui/character_creator/selected_proficiencies.dart';
import 'package:dnd_player_flutter/ui/stat_calculator/stat_calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils.dart';

class SetCharacteristicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetCharacteristicsBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.characteristics),
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _nameField(context),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        _characteristicsDescription(context),
                        SizedBox(height: 24),
                        _characteristics(context),
                      ]),
                ),
              ),
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameField(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SetCharacteristicsBloc, SetCharacteristicsState>(
      builder: (context, state) => TextField(
        cursorColor: Colors.white,
        cursorHeight: 24,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.name,
        ),
        onChanged: (text) {
          BlocProvider.of<SetCharacteristicsBloc>(context)
              .add(SubmitName(text));
        },
        style: theme.textTheme.headline5,
      ),
    );
  }

  Widget _characteristicsDescription(BuildContext context) {
    final theme = Theme.of(context);
    final race = BlocProvider.of<CharacterCreatorBloc>(context).state.race;
    final bonusDescription = race?.abilityBonusDescription;
    if (bonusDescription == null) {
      return SizedBox();
    }
    return Text(
      bonusDescription,
      style: theme.textTheme.subtitle1,
    );
  }

  Widget _characteristics(BuildContext inputContext) {
    final characterState =
        BlocProvider.of<CharacterCreatorBloc>(inputContext).state;
    final raceBonuses = characterState.race?.abilityBonuses;

    return Column(
      children: [
        Characteristic.STRENGTH,
        Characteristic.DEXTERITY,
        Characteristic.CONSTITUTION,
        Characteristic.INTELLIGENCE,
        Characteristic.WISDOM,
        Characteristic.CHARISMA
      ].map((characteristic) {
        final raceBonus = raceBonuses?.firstWhereOrNull((element) =>
            fromIndex(element.abilityScore.index) == characteristic);
        final selectedBonus = characterState.bonusCharacteristic
            ?.firstWhereOrNull(
                (element) => element.characteristic == characteristic);

        final bonusPoints = (raceBonus?.bonus ?? selectedBonus?.bonus) ?? 0;
        return _CharacteristicsRow(
            characteristicBonus:
                CharacteristicBonus(characteristic, bonusPoints));
      }).toList(),
    );
  }

  Widget _submitButton(BuildContext inputContext) {
    return BlocBuilder<SetCharacteristicsBloc, SetCharacteristicsState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
            onPressed: state.isFilled
                ? () {
                    final characterCreatorBloc =
                        BlocProvider.of<CharacterCreatorBloc>(inputContext)
                          ..add(SubmitCharacteristics(
                            state.name,
                            state.strength,
                            state.dexterity,
                            state.constitution,
                            state.intelligence,
                            state.wisdom,
                            state.charisma,
                          ));

                    Navigator.push(
                        inputContext,
                        MaterialPageRoute(
                            builder: (context) => SelectedProficiencies(
                                  clazz: characterCreatorBloc.state.clazz!,
                                )));
                  }
                : null,
            child: Text(AppLocalizations.of(inputContext)!.save)),
      ),
    );
  }
}

class _CharacteristicsRow extends StatelessWidget {
  final CharacteristicBonus characteristicBonus;

  const _CharacteristicsRow({Key? key, required this.characteristicBonus})
      : super(key: key);

  @override
  Widget build(BuildContext rootContext) {
    final theme = Theme.of(rootContext);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Ink(
        decoration: BoxDecoration(
          color: Color(0xFF272E32),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {
            FocusScope.of(rootContext).unfocus();
            Navigator.of(rootContext).push(MaterialPageRoute(
              builder: (context) => StatCalculatorScreen(
                characteristicBonus: characteristicBonus,
                onSubmit: (value) => {
                  BlocProvider.of<SetCharacteristicsBloc>(rootContext).add(
                      SubmitCharacteristicsScore(
                          characteristicBonus.characteristic, value))
                },
              ),
            ));
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: 64,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        characteristicBonus.characteristic.getName(rootContext),
                        style: theme.textTheme.headline5,
                      ),
                      SizedBox(width: 4),
                      if (characteristicBonus.bonus != 0)
                        Text("(${characteristicBonus.bonus.toBonusString()})",
                            style: theme.textTheme.subtitle1),
                    ],
                  ),
                ),
                BlocBuilder<SetCharacteristicsBloc, SetCharacteristicsState>(
                  builder: (context, state) {
                    return Text(
                      ((state.getScoreForCharacteristic(
                                      characteristicBonus.characteristic) ??
                                  0) +
                              characteristicBonus.bonus)
                          .toString(),
                      style: TextStyle(
                          fontSize: 32,
                          color: characteristicBonus.characteristic.getColor()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
