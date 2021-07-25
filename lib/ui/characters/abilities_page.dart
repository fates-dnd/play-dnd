import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/data/skills.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(12),
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
                  Text(skillBonus.skill.name),
                  Text(skillBonus.skill.characteristic.getName())
                ],
              ),
            ),
            Text(skillBonus.bonus >= 0
                ? "+${skillBonus.bonus}"
                : skillBonus.bonus.toString())
          ],
        ),
      ),
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
    if (proficient) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFDCDAD9),
        ),
      );
    } else {
      return DottedBorder(
          borderType: BorderType.Circle,
          color: Color(0xFFDCDAD9),
          child: SizedBox(
            width: 24,
            height: 24,
          ));
    }
  }
}
