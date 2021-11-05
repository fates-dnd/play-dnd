import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/ui/spells/spell_description_row.dart';
import 'package:flutter/material.dart';

class SpellInfoExtended extends StatelessWidget {
  final Spell spell;

  const SpellInfoExtended({Key? key, required this.spell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: theme.primaryColorLight,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            spell.name,
            style: TextStyle(fontSize: 24, color: Color(0xFFDCDAD9)),
          ),
          Text(
            spell.school.toString(),
            style: TextStyle(fontSize: 10, color: Color(0xCCDCDAD9)),
          ),
          SizedBox(height: 12),
          SpellDescriptionRow(name: "Время", value: spell.castingTime),
          SpellDescriptionRow(name: "Дистанция", value: spell.range),
          SpellDescriptionRow(
              name: "Компоненты", value: spell.components.join(", ")),
          SpellDescriptionRow(name: "Длительность", value: spell.duration),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              height: 1,
              color: Color(0xFFDCDAD9),
            ),
          ),
          SizedBox(height: 24),
          Text(spell.description.join("\n\n"))
        ],
      ),
    );
  }
}
