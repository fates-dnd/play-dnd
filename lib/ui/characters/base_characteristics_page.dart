import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'characteristics_colors_map.dart';

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
                accent: characteristicToColor[Characteristic.STRENGTH],
              ),
              CharacteristicItem(
                name: "Ловкость",
                bonus: state.dexterityBonus,
                score: state.dexterity,
                accent: characteristicToColor[Characteristic.DEXTERITY],
              ),
              CharacteristicItem(
                name: "Телосложение",
                bonus: state.constitutionBonus,
                score: state.constitution,
                accent: characteristicToColor[Characteristic.CONSTITUTION],
              ),
              CharacteristicItem(
                name: "Интеллект",
                bonus: state.intelligenceBonus,
                score: state.intelligence,
                accent: characteristicToColor[Characteristic.INTELLECT],
              ),
              CharacteristicItem(
                name: "Мудрость",
                bonus: state.wisdomBonus,
                score: state.wisdom,
                accent: characteristicToColor[Characteristic.WISDOM],
              ),
              CharacteristicItem(
                name: "Харизма",
                bonus: state.charismaBonus,
                score: state.charisma,
                accent: characteristicToColor[Characteristic.CHARISMA],
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
              SavingThrowItem(
                  name: "Сила",
                  bonus: state.strengthSavingThrow,
                  proficient: state.clazz?.savingThrows
                          .contains(Characteristic.STRENGTH) ??
                      false),
              SavingThrowItem(
                name: "Ловкость",
                bonus: state.dexteritySavingThrow,
                proficient: state.clazz?.savingThrows
                        .contains(Characteristic.DEXTERITY) ??
                    false,
              ),
              SavingThrowItem(
                name: "Телосложение",
                bonus: state.constitutionSavingThrow,
                proficient: state.clazz?.savingThrows
                        .contains(Characteristic.CONSTITUTION) ??
                    false,
              ),
              SavingThrowItem(
                name: "Интеллект",
                bonus: state.intelligenceSavingThrow,
                proficient: state.clazz?.savingThrows
                        .contains(Characteristic.INTELLECT) ??
                    false,
              ),
              SavingThrowItem(
                name: "Мудрость",
                bonus: state.wisdomSavingThrow,
                proficient:
                    state.clazz?.savingThrows.contains(Characteristic.WISDOM) ??
                        false,
              ),
              SavingThrowItem(
                name: "Харизма",
                bonus: state.charismaSavingThrow,
                proficient: state.clazz?.savingThrows
                        .contains(Characteristic.CHARISMA) ??
                    false,
              ),
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
  final Color? accent;

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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bonus >= 0 ? "+${bonus.toString()}" : bonus.toString(),
                      style: TextStyle(
                          color: Color(0xFFDCDAD9),
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                    // artificially increased height
                    SizedBox(height: 10),
                  ],
                ),
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
  final bool proficient;

  const SavingThrowItem({
    Key? key,
    required this.name,
    required this.bonus,
    required this.proficient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Color(0xFF272E32)),
      child: Row(
        children: [
          ProficiencyRing(filled: proficient),
          SizedBox(width: 8),
          Expanded(
            child: Text(name, style: theme.textTheme.bodyText2,),
          ),
          Text(bonus >= 0 ? "+$bonus" : bonus.toString(), style: theme.textTheme.bodyText2?.copyWith(fontSize: 14))
        ],
      ),
    );
  }
}

class ProficiencyRing extends StatelessWidget {
  final bool filled;

  const ProficiencyRing({Key? key, required this.filled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Color(0xFFDCDAD9);
    return DottedBorder(
        borderType: BorderType.Circle,
        color: color,
        child: filled ? Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: color),
        ) : SizedBox(
          width: 14,
          height: 14,
        ));
  }
}
