import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/trait.dart';
import 'package:dnd_player_flutter/repository/traits_repository.dart';
import 'package:meta/meta.dart';

part 'traits_event.dart';
part 'traits_state.dart';

class TraitsBloc extends Bloc<TraitsEvent, TraitsState> {
  final TraitsRepository traitsRepository;

  TraitsBloc(this.traitsRepository) : super(TraitsInitial());

  @override
  Stream<TraitsState> mapEventToState(
    TraitsEvent event,
  ) async* {
    if (event is LoadTraitsForRace) {
      final traits = await traitsRepository.getTraits();
      yield TraitsLoaded(traits
          .where((trait) =>
              trait.races.any((race) => race.index == event.raceIndex))
          .toList());
    }
  }
}
