import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:meta/meta.dart';

part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {

  final CharacterRepository repository;

  CharacterListBloc(this.repository) : super(CharacterListState());

  @override
  Stream<CharacterListState> mapEventToState(
    CharacterListEvent event,
  ) async* {
    if (event is LoadCharacterList) {
      final characters = repository.getCharacters();
      yield CharacterListState()
        ..characters = characters;
    }
  }
}
