import 'package:dnd_player_flutter/bloc/traits/traits_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/repository/traits_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RaceDetails extends StatelessWidget {
  final Race race;

  const RaceDetails({Key? key, required this.race}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TraitsBloc>(
      create: (BuildContext context) =>
          TraitsBloc(getIt.get<TraitsRepository>())..add(LoadTraitsForRace(race.index)),
      child: Scaffold(
          appBar: AppBar(
            title: Text(race.name),
            elevation: 0,
          ),
          body: BlocBuilder<TraitsBloc, TraitsState>(
            builder: (context, state) => ListView(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                children: _getItems(context, state)),
          )),
    );
  }

  List<Widget> _getItems(BuildContext context, TraitsState traitsState) {
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

    if (traitsState is TraitsLoaded) {
      traitsState.traits.forEach((trait) {
        items.add(SizedBox(height: 25));
        items.add(_rowItem(context, trait.name + "\n", trait.description.join("\n")));
      });
    }

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
