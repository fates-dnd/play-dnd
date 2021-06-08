import 'package:dnd_player_flutter/bloc/races/races_bloc.dart';
import 'package:dnd_player_flutter/characters/race_details.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/repository/races_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCharRace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RacesBloc(getIt.get<RacesRepository>())..add(LoadRaces()),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: BlocBuilder<RacesBloc, RacesState>(
              buildWhen: (oldState, newState) => newState is RacesLoaded,
              builder: (context, state) => state is RacesEmpty
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Раса",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        SizedBox(height: 24),
                        Expanded(
                          child: PageView.builder(
                              controller: PageController(viewportFraction: 0.9),
                              itemCount: (state as RacesLoaded).races.length,
                              itemBuilder: (context, index) {
                                return RaceCard(
                                    race: state.races[index]);
                              }),
                        ),
                        SizedBox(height: 23,),
                        Center(child: TextButton(onPressed: () {}, child: Text("Выбрать")))
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class RaceCard extends StatelessWidget {
  final Race race;

  const RaceCard({Key? key, required this.race}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorLight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              race.name,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(height: 24),
            Expanded(
              child: Container(
                child: Text(
                  race.description,
                  maxLines: 18,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
            
            Center(child: OutlinedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RaceDetails(race: race)));
            }, child: Text("Подробнее")))
          ],
        ),
      ),
    );
  }
}
