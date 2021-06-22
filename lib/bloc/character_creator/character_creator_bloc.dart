import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/trait.dart';
import 'package:meta/meta.dart';

part 'character_creator_event.dart';
part 'character_creator_state.dart';

class CharacterCreatorBloc extends Bloc<CharacterCreatorEvent, CharacterCreatorState> {

  Race? race;
  List<Trait>? traits;
  Class? clazz;
  List<Characteristic>? bonusCharacteristics;

  CharacterCreatorBloc() : super(CharacterCreatorState());

  @override
  Stream<CharacterCreatorState> mapEventToState(
    CharacterCreatorEvent event,
  ) async* {
    if (event is SubmitRace) {
      race = event.race;
      traits = event.traits;
      
      yield createState();
    } else if (event is SubmitClass) {
      clazz = event.clazz;

      yield createState();
    } else if (event is SubmitBonusCharacteristics) {
      bonusCharacteristics = event.bonusCharacteristics;

      yield createState();
    }
  }

  CharacterCreatorState createState() {
    return CharacterCreatorState(
        race: race, 
        traits: traits, 
        clazz: clazz,
        bonusCharacteristic: bonusCharacteristics,
      );
  }
}
