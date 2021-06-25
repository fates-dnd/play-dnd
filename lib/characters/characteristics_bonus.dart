import 'package:dnd_player_flutter/bloc/character_creator/character_creator_bloc.dart';
import 'package:dnd_player_flutter/bloc/charteristics_bonus/characteristics_bonus_bloc.dart';
import 'package:dnd_player_flutter/characters/set_characteristics.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text(race.abilityBonusDescription,
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 25),
                Expanded(
                  child: Column(
                    children: createCharacteristicsOptions(
                        context, state.characteristicBonuses),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextButton(onPressed: _areOptionsSelected(state) 
                    ? () {
                      final selectedOptions = <CharacteristicBonus>[];
                      state.characteristicBonuses.values.toList().forEach((element) {
                        if (element != null) {
                          selectedOptions.add(element);
                        }
                      });
                      BlocProvider.of<CharacterCreatorBloc>(context).add(SubmitBonusCharacteristics(selectedOptions));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SetCharacteristics()));
                    }
                    : null, child: Text("Выбрать")),
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
      optionsSelected = optionsSelected && state.characteristicBonuses[i] != null;
    }
    return optionsSelected;
  }

  List<Widget> createCharacteristicsOptions(
      BuildContext context, Map<int, CharacteristicBonus?> characteristics) {
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
      CharacteristicBonus? characteristicBonus,
      List<CharacteristicBonus?> selectedCharacteristics,
      ValueChanged<CharacteristicBonus> onChanged) {
    final theme = Theme.of(context);
    final providedOptions = race.abilityBonusOptions?.abilityBonuses
        .map((e) => CharacteristicBonus(requireFromIndex(e.abilityScore.index), e.bonus))
        .toList();
    providedOptions?.removeWhere((provided) =>
        selectedCharacteristics
            .any((selected) => selected?.characteristic.index == provided.characteristic.index) &&
        provided.characteristic.index != characteristicBonus?.characteristic.index);

    return DropdownButton(
      hint: Text(
        hint,
        style: TextStyle(color: Color(0xffa4a4a4)),
      ),
      value: characteristicBonus?.characteristic,
      underline: Container(height: 2, color: theme.accentColor),
      dropdownColor: theme.primaryColorLight,
      icon: Icon(Icons.arrow_drop_down),
      items: providedOptions?.map((e) {
        return DropdownMenuItem<Characteristic>(
            value: e.characteristic, child: Text(e.characteristic.getName()));
      }).toList(),
      onChanged: (value) { 
        final selectedCharacteristicBonus 
          = providedOptions?.toList().firstWhere((element) => element.characteristic == value);
        if (selectedCharacteristicBonus != null) {
          onChanged(selectedCharacteristicBonus); 
        }
      },
    );
  }
}
