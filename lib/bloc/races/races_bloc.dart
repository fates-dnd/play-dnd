import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/repository/races_repository.dart';
import 'package:meta/meta.dart';

part 'races_event.dart';
part 'races_state.dart';

class RacesBloc extends Bloc<RacesEvent, RacesState> {

  final RacesRepository racesRepository;

  RacesBloc(this.racesRepository) : super(RacesEmpty());

  @override
  Stream<RacesState> mapEventToState(
    RacesEvent event,
  ) async* {
    if (event is LoadRaces) {
      final races = await racesRepository.readRaces();
      yield RacesLoaded(races);
    }
  }
}
