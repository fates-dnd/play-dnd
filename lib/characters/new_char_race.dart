import 'package:dnd_player_flutter/bloc/races/races_bloc.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/repository/races_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCharRace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RacesBloc(RacesRepository())..add(LoadRaces()),
      child: Scaffold(
        body: BlocBuilder<RacesBloc, RacesState>(
          buildWhen: (oldState, newState) => newState is RacesLoaded,
          builder: (context, state) => state is RacesEmpty ? SizedBox() : Column(
            children: [
              Expanded(
                child: PageView.builder(itemBuilder: (context, index) {
                  return RaceCard(race: (state as RacesLoaded).races[index]);
                }),
              )
            ],
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
      child: Column(
        children: [
          Text(
            race.name,
            style: Theme.of(context).textTheme.headline2,
          )
        ],
      ),
    );
  }
}
