import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:meta/meta.dart';

part 'set_characteristics_event.dart';
part 'set_characteristics_state.dart';

class SetCharacteristicsBloc
    extends Bloc<SetCharacteristicsEvent, SetCharacteristicsState> {
  int level = 1;
  int? strenghBase;
  int? dexterityBase;
  int? constitutionBase;
  int? intelligenceBase;
  int? wisdomBase;
  int? charismaBase;

  SetCharacteristicsBloc() : super(SetCharacteristicsState(level: 1));

  @override
  Stream<SetCharacteristicsState> mapEventToState(
    SetCharacteristicsEvent event,
  ) async* {
    if (event is SubmitLevel) {
      level = event.level;
    } else if (event is SubmitCharacteristicsScore) {
      _saveCharacteristicsScore(event.characteristic, event.score);
    }
    yield SetCharacteristicsState(
        level: level,
        strength: strenghBase,
        dexterity: dexterityBase,
        constitution: constitutionBase,
        intelligence: intelligenceBase,
        wisdom: wisdomBase,
        charisma: charismaBase);
  }

  _saveCharacteristicsScore(Characteristic characteristic, int? score) {
    switch (characteristic) {
      case Characteristic.STRENGTH:
        strenghBase = score;
        break;
      case Characteristic.DEXTERITY:
        dexterityBase = score;
        break;
      case Characteristic.CONSTITUTION:
        constitutionBase = score;
        break;
      case Characteristic.INTELLECT:
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
