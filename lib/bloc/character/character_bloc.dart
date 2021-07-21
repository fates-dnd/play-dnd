import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/bloc/character/proficiency_bonus_table.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:meta/meta.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {

  late Character character;

  CharacterBloc() : super(CharacterState());

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    if (event is SetCharacter) {
      character = event.character;

      yield CharacterState(
        level: character.level,
        strength: character.baseStrength,
        dexterity: character.baseDexterity,
        constitution: character.baseConstitution,
        intelligence: character.baseIntelligence,
        wisdom: character.baseWisdom,
        charisma: character.baseCharisma,
      );
    }
  }
}
