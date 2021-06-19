import 'package:dnd_player_flutter/bloc/charteristics_bonus/characteristics_bonus_bloc.dart';
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
            ]..addAll(createCharacteristicsOptions(context, state.characteristics))),
          ),
        ),
      ),
    );
  }

  List<Widget> createCharacteristicsOptions(BuildContext context, Map<int, Characteristic?> characteristics) {
    final options = <Widget>[];
    for (var i = 1; i <= (race.abilityBonusOptions?.choose ?? 0); ++i) {
      options.add(_createCharacteristicsSelect(
          context, "Характеристика $i", characteristics.length >= i ? characteristics[i] : null, (value) {
            BlocProvider.of<CharacteristicsBonusBloc>(context).add(SelectBonusCharacteristic(i, value));
          }));
      options.add(SizedBox(height: 12));
    }
    return options;
  }

  DropdownButton _createCharacteristicsSelect(
      BuildContext context, String hint, Characteristic? characteristic, ValueChanged<Characteristic> onChanged) {
    final theme = Theme.of(context);
    return DropdownButton(
      hint: Text(
        hint,
        style: TextStyle(color: Color(0xffa4a4a4)),
      ),
      value: characteristic,
      underline: Container(height: 2, color: theme.accentColor),
      dropdownColor: theme.primaryColorLight,
      icon: Icon(Icons.arrow_drop_down),
      items: <Characteristic>[
        Strength(),
        Dexterity(),
        Constitution(),
        Intellect(),
        Wisdom(),
        Charisma()
      ]
          .map((e) =>
              DropdownMenuItem<Characteristic>(value: e, child: Text(e.name)))
          .toList(),
      onChanged: (value) => onChanged(value),
    );
  }
}
