import 'package:dnd_player_flutter/bloc/character_creator/character_creator/character_creator_bloc.dart';
import 'package:dnd_player_flutter/bloc/character_creator/charteristics_bonus/characteristics_bonus_bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/ui/character_creator/set_characteristics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CharacteristicsBonus extends StatelessWidget {
  final Race race;

  const CharacteristicsBonus({Key? key, required this.race}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacteristicsBonusBloc(race),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Бонус характеристик"),
          elevation: 0,
        ),
        body: BlocBuilder<CharacteristicsBonusBloc, CharacteristicsBonusState>(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                Text(race.abilityBonusDescription,
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 25),
                Expanded(
                  child: Column(
                    children: createCharacteristicsOptions(
                        context, state.characteristicBonuses),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextButton(
                      onPressed: _areOptionsSelected(state)
                          ? () {
                              final selectedOptions = <AbilityBonus>[];
                              state.characteristicBonuses.values
                                  .toList()
                                  .forEach((element) {
                                if (element != null) {
                                  selectedOptions.add(element);
                                }
                              });
                              BlocProvider.of<CharacterCreatorBloc>(context)
                                  .add(SubmitBonusCharacteristics(
                                      selectedOptions));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      SetCharacteristicsScreen()));
                            }
                          : null,
                      child: Text(AppLocalizations.of(context)!.select)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _areOptionsSelected(CharacteristicsBonusState state) {
    bool optionsSelected = true;
    for (var i = 1; i <= (race.abilityBonusOptions?.choose ?? 0); ++i) {
      optionsSelected =
          optionsSelected && state.characteristicBonuses[i] != null;
    }
    return optionsSelected;
  }

  List<Widget> createCharacteristicsOptions(
      BuildContext context, Map<int, AbilityBonus?> characteristics) {
    final options = <Widget>[];
    for (var i = 1; i <= (race.abilityBonusOptions?.choose ?? 0); ++i) {
      options.add(_createCharacteristicsSelect(
          context,
          "Характеристика $i",
          characteristics.length >= i ? characteristics[i] : null,
          characteristics.values.toList(), (value) {
        BlocProvider.of<CharacteristicsBonusBloc>(context)
            .add(SelectBonusCharacteristic(i, value));
      }));
      options.add(SizedBox(height: 12));
    }
    return options;
  }

  DropdownButton _createCharacteristicsSelect(
      BuildContext context,
      String hint,
      AbilityBonus? characteristicBonus,
      List<AbilityBonus?> selectedCharacteristics,
      ValueChanged<AbilityBonus> onChanged) {
    final theme = Theme.of(context);
    final providedOptions = race.abilityBonusOptions?.abilityBonuses
        .map((e) => AbilityBonus(e.characteristic, e.bonus))
        .toList();
    providedOptions?.removeWhere((provided) =>
        selectedCharacteristics.any((selected) =>
            selected?.characteristic.index == provided.characteristic.index) &&
        provided.characteristic.index !=
            characteristicBonus?.characteristic.index);

    return DropdownButton(
      isExpanded: true,
      hint: Text(
        hint,
        style: TextStyle(color: Color(0xffa4a4a4), fontSize: 28),
      ),
      value: characteristicBonus?.characteristic,
      underline: SizedBox(),
      dropdownColor: theme.primaryColorLight,
      icon: Icon(Icons.arrow_drop_down),
      items: providedOptions?.map((e) {
        return DropdownMenuItem<Characteristic>(
            value: e.characteristic,
            child: Text(
              e.characteristic.getName(context),
              style: TextStyle(fontSize: 28, color: Colors.white),
            ));
      }).toList(),
      onChanged: (value) {
        final selectedCharacteristicBonus = providedOptions
            ?.toList()
            .firstWhere((element) => element.characteristic == value);
        if (selectedCharacteristicBonus != null) {
          onChanged(selectedCharacteristicBonus);
        }
      },
    );
  }
}
