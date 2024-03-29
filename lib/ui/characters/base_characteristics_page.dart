import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BaseCharateristicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) => ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              physics: NeverScrollableScrollPhysics(),
              children: [
                CharacteristicItem(
                  name: localizations.strength,
                  bonus: state.strengthBonus,
                  score: state.totalStrength,
                  accent: Characteristic.STRENGTH.getColor(),
                ),
                CharacteristicItem(
                  name: localizations.dexterity,
                  bonus: state.dexterityBonus,
                  score: state.totalDexterity,
                  accent: Characteristic.DEXTERITY.getColor(),
                ),
                CharacteristicItem(
                  name: localizations.constitution,
                  bonus: state.constitutionBonus,
                  score: state.totalConstitution,
                  accent: Characteristic.CONSTITUTION.getColor(),
                ),
                CharacteristicItem(
                  name: localizations.intelligence,
                  bonus: state.intelligenceBonus,
                  score: state.totalIntelligence,
                  accent: Characteristic.INTELLIGENCE.getColor(),
                ),
                CharacteristicItem(
                  name: localizations.wisdom,
                  bonus: state.wisdomBonus,
                  score: state.totalWisdom,
                  accent: Characteristic.WISDOM.getColor(),
                ),
                CharacteristicItem(
                  name: localizations.charisma,
                  bonus: state.charismaBonus,
                  score: state.totalCharisma,
                  accent: Characteristic.CHARISMA.getColor(),
                ),
              ],
            ),
            SizedBox(height: 32),
            Text(localizations.saving_throws, style: theme.textTheme.headline2),
            SizedBox(height: 16),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SavingThrowItem(
                    name: localizations.strength,
                    bonus: state.strengthSavingThrow,
                    proficient: state.clazz?.savingThrows
                            .contains(Characteristic.STRENGTH) ??
                        false),
                SavingThrowItem(
                  name: localizations.dexterity,
                  bonus: state.dexteritySavingThrow,
                  proficient: state.clazz?.savingThrows
                          .contains(Characteristic.DEXTERITY) ??
                      false,
                ),
                SavingThrowItem(
                  name: localizations.constitution,
                  bonus: state.constitutionSavingThrow,
                  proficient: state.clazz?.savingThrows
                          .contains(Characteristic.CONSTITUTION) ??
                      false,
                ),
                SavingThrowItem(
                  name: localizations.intelligence,
                  bonus: state.intelligenceSavingThrow,
                  proficient: state.clazz?.savingThrows
                          .contains(Characteristic.INTELLIGENCE) ??
                      false,
                ),
                SavingThrowItem(
                  name: localizations.wisdom,
                  bonus: state.wisdomSavingThrow,
                  proficient: state.clazz?.savingThrows
                          .contains(Characteristic.WISDOM) ??
                      false,
                ),
                SavingThrowItem(
                  name: localizations.charisma,
                  bonus: state.charismaSavingThrow,
                  proficient: state.clazz?.savingThrows
                          .contains(Characteristic.CHARISMA) ??
                      false,
                ),
              ],
            ),
          ],
        ),
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
                  fontSize: 14,
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
                        fontSize: 52,
                      ),
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
            width: 70,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.primaryColor,
                width: 5,
              ),
              color: theme.primaryColorLight,
            ),
            alignment: Alignment.center,
            child: Text(
              score.toString(),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accent,
                border: Border.all(
                  color: theme.primaryColor,
                  width: 5,
                )),
            child: Image.asset(
              "assets/drawable/dice/d20.png",
              width: 16,
              height: 16,
            ),
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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: Color(0xFF272E32)),
          child: Row(
            children: [
              ProficiencyRing(filled: proficient),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Text(
                bonus.toBonusString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 12,
        )
      ],
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
        child: filled
            ? Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              )
            : SizedBox(
                width: 14,
                height: 14,
              ));
  }
}
