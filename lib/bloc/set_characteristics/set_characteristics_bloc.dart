import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:meta/meta.dart';

part 'set_characteristics_event.dart';
part 'set_characteristics_state.dart';

class SetCharacteristicsBloc
    extends Bloc<SetCharacteristicsEvent, SetCharacteristicsState> {
  String? name;
  int? strenghtBase;
  int? dexterityBase;
  int? constitutionBase;
  int? intelligenceBase;
  int? wisdomBase;
  int? charismaBase;

  SetCharacteristicsBloc() : super(SetCharacteristicsState()) {
    on<SetCharacteristicsEvent>((event, emit) async {
      emit(await processEvent(event));
    });
  }

  Future<SetCharacteristicsState> processEvent(
    SetCharacteristicsEvent event,
  ) async {
    if (event is SubmitName) {
      name = event.name;
    } else if (event is SubmitCharacteristicsScore) {
      _saveCharacteristicsScore(event.characteristic, event.score);
    }
    return SetCharacteristicsState(
        name: name,
        strength: strenghtBase,
        dexterity: dexterityBase,
        constitution: constitutionBase,
        intelligence: intelligenceBase,
        wisdom: wisdomBase,
        charisma: charismaBase);
  }

  _saveCharacteristicsScore(Characteristic characteristic, int? score) {
    switch (characteristic) {
      case Characteristic.STRENGTH:
        strenghtBase = score;
        break;
      case Characteristic.DEXTERITY:
        dexterityBase = score;
        break;
      case Characteristic.CONSTITUTION:
        constitutionBase = score;
        break;
      case Characteristic.INTELLIGENCE:
        intelligenceBase = score;
        break;
      case Characteristic.WISDOM:
        wisdomBase = score;
        break;
      case Characteristic.CHARISMA:
        charismaBase = score;
        break;
    }
  }
}
