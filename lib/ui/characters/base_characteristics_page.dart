import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseCharateristicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) => GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        children: [
          CharacteristicItem(
            name: "Сила",
            bonus: state.strengthBonus,
            score: state.strength,
          ),
          CharacteristicItem(
            name: "Ловкость",
            bonus: state.dexterityBonus,
            score: state.dexterity,
          ),
          CharacteristicItem(
            name: "Телосложение",
            bonus: state.constitutionBonus,
            score: state.constitution,
          ),
          CharacteristicItem(
            name: "Интеллект",
            bonus: state.intelligenceBonus,
            score: state.intelligence,
          ),
          CharacteristicItem(
            name: "Мудрость",
            bonus: state.wisdomBonus,
            score: state.wisdom,
          ),
          CharacteristicItem(
            name: "Харизма",
            bonus: state.charismaBonus,
            score: state.charisma,
          ),
        ],
      ),
    );
  }
}

class CharacteristicItem extends StatelessWidget {
  final String name;
  final int bonus;
  final int score;

  const CharacteristicItem(
      {Key? key, required this.name, required this.bonus, required this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: theme.primaryColorLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.primaryColor,
                width: 5,
              )),
          child: Column(
            children: [
              Text(
                name.toUpperCase(),
                style: TextStyle(
                  color: Color(0xFF9D9D9D),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                bonus >= 0 ? "+${bonus.toString()}" : bonus.toString(),
                style: TextStyle(
                  color: Color(0xFFDCDAD9),
                  fontSize: 38,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
