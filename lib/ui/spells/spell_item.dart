import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:flutter/material.dart';

class SpellItem extends StatelessWidget {
  final Spell spell;

  const SpellItem({Key? key, required this.spell}) : super(key: key);

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
          Row(children: [
            Expanded(
              child: _SpellTitle(spell: spell),
            ),
            SizedBox(
              width: 8,
            ),
            _PrepareButton(),
          ]),
          SizedBox(height: 2),
          Text(spell.school.toString(),
              style: TextStyle(fontSize: 10, color: Color(0xCCDCDAD9))),
          SizedBox(height: 5),
          _DescriptionRow(name: "Время", value: spell.castingTime),
          _DescriptionRow(name: "Дистанция", value: spell.range),
          _DescriptionRow(
              name: "Компоненты", value: spell.components.join(", ")),
          _DescriptionRow(name: "Длительность", value: spell.duration),
        ],
      ),
    );
  }
}

class _PrepareButton extends StatelessWidget {
  const _PrepareButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      child: OutlinedButton(
        onPressed: () {},
        child: Text(
          "Подготовить",
          style: TextStyle(fontSize: 12),
        ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 8, vertical: 0)),
            side: MaterialStateProperty.all(
                BorderSide(color: Color(0xFFFF5251), width: 1))),
      ),
    );
  }
}

class _SpellTitle extends StatelessWidget {
  final Spell spell;

  const _SpellTitle({Key? key, required this.spell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(text: spell.name, style: TextStyle(fontSize: 18)),
      WidgetSpan(
          child: SizedBox(
        width: 8,
      )),
      if (spell.concentration) WidgetSpan(child: _ConcentrationMark())
    ]));
  }
}

class _ConcentrationMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/shape/romb.png",
          width: 20,
          height: 20,
        ),
        Text(
          "к",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class _DescriptionRow extends StatelessWidget {
  final String name;
  final String value;

  const _DescriptionRow({Key? key, required this.name, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      children: [
        TextSpan(
            text: name + ": ",
            style: TextStyle(color: Color(0xAADCDAD9), fontSize: 12)),
        TextSpan(
            text: value,
            style: TextStyle(color: Color(0xFFDCDAD9), fontSize: 12)),
      ],
    ));
  }
}
