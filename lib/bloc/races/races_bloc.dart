import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/trait.dart';
import 'package:dnd_player_flutter/repository/races_repository.dart';
import 'package:dnd_player_flutter/repository/traits_repository.dart';
import 'package:meta/meta.dart';

part 'races_event.dart';
part 'races_state.dart';

class RacesBloc extends Bloc<RacesEvent, RacesState> {
  final RacesRepository racesRepository;
  final TraitsRepository traitsRepository;

  RacesBloc(this.racesRepository, this.traitsRepository) : super(RacesEmpty()) {
    on<RacesEvent>((event, emit) async {
      emit(await processEvent(event));
    });
  }

  Future<RacesState> processEvent(
    RacesEvent event,
  ) async {
    if (event is LoadRaces) {
      final races = await racesRepository.getRaces();
      final traits = await traitsRepository.getTraits();
      final racesWithTraits = Map<Race, List<Trait>>.fromIterable(races,
          key: (race) => race,
          value: (event) => traits
              .where((trait) =>
                  trait.races.any((race) => race.index == event.index))
              .toList());
      return RacesLoaded(racesWithTraits);
    }

    return state;
  }
}
