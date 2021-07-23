import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseCharateristicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) => ListView(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            children: [
              CharacteristicItem(
                name: "Сила",
                bonus: state.strengthBonus,
                score: state.strength,
                accent: Color(0xFFFF5251),
              ),
              CharacteristicItem(
                name: "Ловкость",
                bonus: state.dexterityBonus,
                score: state.dexterity,
                accent: Color(0xFF3AFFBD),
              ),
              CharacteristicItem(
                name: "Телосложение",
                bonus: state.constitutionBonus,
                score: state.constitution,
                accent: Color(0xFFFB9538),
              ),
              CharacteristicItem(
                name: "Интеллект",
                bonus: state.intelligenceBonus,
                score: state.intelligence,
                accent: Color(0xFFE5E1DE),
              ),
              CharacteristicItem(
                name: "Мудрость",
                bonus: state.wisdomBonus,
                score: state.wisdom,
                accent: Color(0xFF4847FB),
              ),
              CharacteristicItem(
                name: "Харизма",
                bonus: state.charismaBonus,
                score: state.charisma,
                accent: Color(0xFFC01DFC),
              ),
            ],
          ),
          SizedBox(height: 28),
          Text("Спас броски", style: theme.textTheme.headline2),
          SizedBox(height: 12),
          GridView.count(
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 4 / 1,
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              SavingThrowItem(name: "Сила", bonus: 0),
              SavingThrowItem(name: "Ловкость", bonus: 0),
              SavingThrowItem(name: "Телосложение", bonus: 0),
              SavingThrowItem(name: "Интеллект", bonus: 0),
              SavingThrowItem(name: "Мудрость", bonus: 0),
              SavingThrowItem(name: "Харизма", bonus: 0),
            ],
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
  final Color accent;

  const CharacteristicItem({
    Key? key,
    required this.name,
    required this.bonus,
    required this.score,
    required this.accent,
  }) : super(key: key);

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
              borderRadius: BorderRadius.circular(16),
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
                height: 10,
              ),
              Text(
                bonus >= 0 ? "+${bonus.toString()}" : bonus.toString(),
                style: TextStyle(
                    color: Color(0xFFDCDAD9),
                    fontSize: 38,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.primaryColor,
                width: 5,
              ),
              color: theme.primaryColorLight,
            ),
            alignment: Alignment.center,
            child: Text(score.toString()),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accent,
                border: Border.all(
                  color: theme.primaryColor,
                  width: 5,
                )),
            child: Image.asset("assets/dice/d20.png"),
          ),
        ),
      ],
    );
  }
}

class SavingThrowItem extends StatelessWidget {
  final String name;
  final int bonus;

  const SavingThrowItem({Key? key, required this.name, required this.bonus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF272E32)
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(name),
          ),
          Text(
            bonus >= 0 ? "+$bonus" : bonus.toString()
          )
        ],
      ),
    );
  }
}
