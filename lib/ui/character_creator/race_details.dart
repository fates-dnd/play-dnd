import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/trait.dart';
import 'package:flutter/material.dart';

class RaceDetails extends StatelessWidget {
  final Race race;
  final List<Trait> traits;

  const RaceDetails({Key? key, required this.race, required this.traits})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(race.name),
        elevation: 0,
      ),
      body: ListView(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          children: _getItems(context)),
    );
  }

  List<Widget> _getItems(BuildContext context) {
    final items = [
      Text(
        race.description,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      SizedBox(
        height: 25,
      ),
      _rowItem(context, 'Увеличение характеристик. ', race.description),
      SizedBox(
        height: 25,
      ),
      _rowItem(context, 'Возраст. ', race.age),
      SizedBox(
        height: 25,
      ),
      _rowItem(context, "Мировозрение. ", race.alignment),
      SizedBox(
        height: 25,
      ),
      _rowItem(context, "Размер. ", race.sizeDescription),
      SizedBox(
        height: 25,
      ),
      _rowItem(context, "Скорость. ",
          "Ваша базовая скорость - ${race.baseSpeed} футов."),
      SizedBox(
        height: 25,
      ),
      _rowItem(context, "Языки. ", race.languagesDescription),
    ];

    traits.forEach((trait) {
      items.add(SizedBox(height: 25));
      items.add(
          _rowItem(context, trait.name + "\n", trait.description.join("\n")));
    });

    return items;
  }

  Widget _rowItem(BuildContext context, String title, String body) {
    final theme = Theme.of(context).textTheme.bodyText2;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: title, style: theme?.copyWith(fontWeight: FontWeight.bold)),
          WidgetSpan(
              child: Opacity(
                  opacity: 0.8,
                  child: Text(
                    body,
                    style: theme,
                  ))),
        ],
      ),
    );
  }
}
