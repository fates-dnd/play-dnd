import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:meta/meta.dart';

part 'characteristics_bonus_event.dart';
part 'characteristics_bonus_state.dart';

class CharacteristicsBonusBloc
    extends Bloc<CharacteristicsBonusEvent, CharacteristicsBonusState> {
  final Race race;

  Map<int, CharacteristicBonus?> selectedCharacteristics = {};

  CharacteristicsBonusBloc(this.race) : super(CharacteristicsBonusState({})) {
    for (var i = 1; i <= (race.abilityBonusOptions?.choose ?? 0); ++i) {
      selectedCharacteristics[i] = null;
    }

    on<CharacteristicsBonusEvent>((event, emit) async {
      emit(await processEvent(event));
    });
  }

  Future<CharacteristicsBonusState> processEvent(
    CharacteristicsBonusEvent event,
  ) async {
    if (event is SelectBonusCharacteristic) {
      selectedCharacteristics[event.position] = event.characteristicBonus;
      return CharacteristicsBonusState(selectedCharacteristics);
    }

    return state;
  }
}
