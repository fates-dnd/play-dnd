import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/data/skills.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbilitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) => ListView.builder(
          itemCount: state.skillBonuses.length,
          itemBuilder: (context, index) {
            final item = state.skillBonuses[index];
            return AbilityItem(
              skillBonus: item,
            );
          }),
    );
  }
}

class AbilityItem extends StatelessWidget {
  final SkillBonus skillBonus;

  const AbilityItem({Key? key, required this.skillBonus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 28),
            decoration: BoxDecoration(
              color: theme.primaryColorLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                AbilityProficiencyIndicator(proficient: skillBonus.proficient),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skillBonus.skill.name,
                        style: theme.textTheme.headline5,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        skillBonus.skill.characteristic
                            .getName(context)
                            .toUpperCase(),
                        style: theme.textTheme.subtitle2,
                      )
                    ],
                  ),
                ),
                Text(
                  skillBonus.bonus.toBonusString(),
                  style: theme.textTheme.headline2,
                )
              ],
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
              color: skillBonus.skill.characteristic.getColor(),
            ),
            child: Image.asset("assets/drawable/dice/d20.png"),
          ),
        ),
      ],
    );
  }
}

class AbilityProficiencyIndicator extends StatelessWidget {
  final bool proficient;

  const AbilityProficiencyIndicator({
    Key? key,
    required this.proficient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [7, 4],
      borderType: BorderType.Circle,
      color: Color(0xFFDCDAD9),
      child: proficient
          ? Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFDCDAD9),
              ),
            )
          : SizedBox(
              width: 24,
              height: 24,
            ),
    );
  }
}
