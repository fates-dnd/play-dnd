import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:meta/meta.dart';

part 'characteristics_bonus_event.dart';
part 'characteristics_bonus_state.dart';

class CharacteristicsBonusBloc extends Bloc<CharacteristicsBonusEvent, CharacteristicsBonusState> {

  final Race race;

  Map<int, Characteristic?> selectedCharacteristics = {};

  CharacteristicsBonusBloc(this.race) : super(CharacteristicsBonusState({})) {
    for (var i = 1; i <= (race.abilityBonusOptions?.choose ?? 0); ++i) {
      selectedCharacteristics[i] = null;
    }
  }

  @override
  Stream<CharacteristicsBonusState> mapEventToState(
    CharacteristicsBonusEvent event,
  ) async* {
    if (event is SelectBonusCharacteristic) {
      selectedCharacteristics[event.position] = event.characteristic;
      yield CharacteristicsBonusState(selectedCharacteristics);
    }
  }
}
