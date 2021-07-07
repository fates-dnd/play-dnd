import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/trait.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:meta/meta.dart';

part 'character_creator_event.dart';
part 'character_creator_state.dart';

class CharacterCreatorBloc extends Bloc<CharacterCreatorEvent, CharacterCreatorState> {

  final CharacterRepository repository;

  CharacterCreatorBloc(this.repository) : super(CharacterCreatorState());

  @override
  Stream<CharacterCreatorState> mapEventToState(
    CharacterCreatorEvent event,
  ) async* {
    if (event is SubmitRace) {
      yield state.copyWith(
        race: event.race,
        traits: event.traits,
      );
    } else if (event is SubmitClass) {
      yield state.copyWith(
        clazz: event.clazz
      );
    } else if (event is SubmitBonusCharacteristics) {
      yield state.copyWith(
        bonusCharacteristic: event.bonusCharacteristics
      );
    } else if (event is SubmitCharacteristics) {
      yield state.copyWith(
        name: event.name,
        level: event.level,
        strength: event.strength,
        dexterity: event.dexterity,
        constitution: event.constitution,
        intelligence: event.intelligence,
        wisdom: event.wisdom,
        charisma: event.charisma,
      );

      final characterToSave = state.toCharacter();
      if (characterToSave != null) {
        repository.insertCharacter(characterToSave);
      }
    }
  }
}
