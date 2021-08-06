import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/bloc/character/proficiency_bonus_table.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/data/skills.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:meta/meta.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {

  final SkillsRepository skillsRepository;

  late Character character;

  CharacterBloc(this.skillsRepository) : super(CharacterState());

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
        race: character.race,
        clazz: character.clazz,
        skills: await skillsRepository.getSkills(),
      );
    } else if (event is SelectEquipmentItem) {
      
    } else if (event is RemoveEquipmentItem) {

    }
  }
}
