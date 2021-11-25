import 'package:dnd_player_flutter/bloc/character_creator/character_creator_bloc.dart';
import 'package:dnd_player_flutter/bloc/set_characteristics/set_characteristics_bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/ui/stat_calculator/stat_calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils.dart';

class SetCharacteristicsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SetCharacteristicsScreenState();
  }
}

class SetCharacteristicsScreenState extends State<SetCharacteristicsScreen> {
  late FocusNode nameFocusNode;

  @override
  void initState() {
    nameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    super.dispose();
  }

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
                            SizedBox(width: 48),
                            _levelField(context)
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
        focusNode: nameFocusNode,
        cursorColor: theme.accentColor,
        cursorHeight: 24,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.level,
        ),
        onChanged: (text) {
          BlocProvider.of<SetCharacteristicsBloc>(context)
              .add(SubmitName(text));
        },
        style: theme.textTheme.headline5,
      ),
    );
  }

  Widget _levelField(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.level,
          style: theme.textTheme.subtitle2,
        ),
        BlocBuilder<SetCharacteristicsBloc, SetCharacteristicsState>(
          builder: (context, state) => DropdownButton(
            itemHeight: 52,
            hint: Text(
              AppLocalizations.of(context)!.level,
              style: TextStyle(color: Color(0xffa4a4a4)),
            ),
            value: state.level,
            underline: Container(height: 2, color: theme.accentColor),
            dropdownColor: theme.primaryColorLight,
            icon: Icon(Icons.arrow_drop_down),
            items: List.generate(20, (index) => index + 1).map((e) {
              return DropdownMenuItem<int>(
                  value: e,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      e.toString(),
                      style: theme.textTheme.headline5,
                    ),
                  ));
            }).toList(),
            onChanged: (value) => {
              BlocProvider.of<SetCharacteristicsBloc>(context)
                  .add(SubmitLevel(value as int))
            },
          ),
        ),
      ],
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
        return _characteristicsRow(
            context, CharacteristicBonus(characteristic, bonusPoints));
      }).toList(),
    );
  }

  Widget _characteristicsRow(
      BuildContext context, CharacteristicBonus characteristicBonus) {
    final theme = Theme.of(context);
    return Container(
      height: 48,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  characteristicBonus.characteristic.getName(context),
                  style: theme.textTheme.headline5,
                ),
                SizedBox(width: 4),
                if (characteristicBonus.bonus != 0)
                  Text("(${characteristicBonus.bonus.toBonusString()})",
                      style: theme.textTheme.subtitle1),
              ],
            ),
          ),
          _characteristicButton(context, characteristicBonus)
        ],
      ),
    );
  }

  Widget _characteristicButton(
      BuildContext inputContext, CharacteristicBonus characteristicBonus) {
    return BlocBuilder<SetCharacteristicsBloc, SetCharacteristicsState>(
      builder: (blocContext, state) => OutlinedButton(
        onPressed: () {
          nameFocusNode.unfocus();
          Navigator.of(blocContext).push(MaterialPageRoute(
            builder: (context) => StatCalculatorScreen(
              characteristicBonus: characteristicBonus,
              onSubmit: (value) => {
                BlocProvider.of<SetCharacteristicsBloc>(blocContext).add(
                    SubmitCharacteristicsScore(
                        characteristicBonus.characteristic, value))
              },
            ),
          ));
        },
        child: Text(((state.getScoreForCharacteristic(
                        characteristicBonus.characteristic) ??
                    0) +
                characteristicBonus.bonus)
            .toString()),
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          side: BorderSide(color: Color(0xFF272E32), width: 3),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext inputContext) {
    return BlocBuilder<SetCharacteristicsBloc, SetCharacteristicsState>(
      builder: (contetxt, state) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
            onPressed: state.isFilled
                ? () {
                    BlocProvider.of<CharacterCreatorBloc>(inputContext)
                        .add(SubmitCharacteristics(
                      state.name,
                      state.level,
                      state.strength,
                      state.dexterity,
                      state.constitution,
                      state.intelligence,
                      state.wisdom,
                      state.charisma,
                    ));

                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (r) => false);
                  }
                : null,
            child: Text(AppLocalizations.of(context)!.save)),
      ),
    );
  }
}
