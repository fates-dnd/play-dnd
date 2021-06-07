import 'package:dnd_player_flutter/dto/race.dart';
import 'package:flutter/material.dart';

class RaceDetails extends StatelessWidget {
  final Race race;

  const RaceDetails({Key? key, required this.race}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(race.name),
          elevation: 0,
        ),
        body:
            ListView(padding: EdgeInsets.symmetric(horizontal: 16), children: [
          Text(
            race.description,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 25,
          ),
          _rowItem(context, 'Увеличение характеристик.', race.description),
          SizedBox(
            height: 25,
          ),
          _rowItem(context, 'Возраст.', race.age)
        ]));
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
