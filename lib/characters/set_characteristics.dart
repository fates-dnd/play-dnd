import 'package:dnd_player_flutter/bloc/character_creator/character_creator_bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetCharacteristics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Характеристики"),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
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
          ],
        ),
      ),
    );
  }

  Widget _nameField(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      cursorColor: theme.accentColor,
      cursorHeight: 24,
      decoration: InputDecoration(
          hintText: "Имя",
          hintStyle: TextStyle(color: Color(0xAAE5E1DE), fontSize: 18),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.accentColor, width: 2)
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.accentColor, width: 2)
          ),
          border: UnderlineInputBorder()),
      style: theme.textTheme.headline5,
    );
  }

  Widget _levelField(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text("Уровень", style: theme.textTheme.subtitle2,),
        DropdownButton(
          itemHeight: 52,
          hint: Text(
            "Уровень",
            style: TextStyle(color: Color(0xffa4a4a4)),
          ),
          value: 1,
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
          onChanged: (value) => {},
        ),
      ],
    );
  }

  Widget _characteristicsDescription(BuildContext context) {
    final theme = Theme.of(context);
    final race = BlocProvider.of<CharacterCreatorBloc>(context).race;
    final bonusDescription = race?.abilityBonusDescription;
    if (bonusDescription == null) {
      return SizedBox();
    }
    return Text(
      bonusDescription,
      style: theme.textTheme.bodyText1,
    );
  }

  Widget _characteristicsRow(BuildContext context, Characteristic characteristic) {
    final characterCreator = BlocProvider.of<CharacterCreatorBloc>(context);
    final race = characterCreator.race;
    final abilityBonus = characterCreator.bonusCharacteristics;
    return Row(
      children: [
        
      ],
    );
  }
}
