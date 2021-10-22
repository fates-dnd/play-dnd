import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:flutter/material.dart';

class SpellItem extends StatelessWidget {
  final Spell spell;

  const SpellItem({Key? key, required this.spell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SpellTitle(spell: spell),
          Text(spell.school.toString()),
        ],
      ),
    );
  }
}

class _SpellTitle extends StatelessWidget {
  final Spell spell;

  const _SpellTitle({Key? key, required this.spell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(spell.name, style: TextStyle(color:),),
        SizedBox(width: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/shape/romb.png",
              width: 20,
              height: 20,
            ),
            Text(
              "к",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }
}
