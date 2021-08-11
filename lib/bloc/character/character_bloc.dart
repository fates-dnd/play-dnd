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
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:meta/meta.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;
  final SkillsRepository skillsRepository;
  final EquipmentRepository equipmentRepository;

  late Character character;

  CharacterBloc(
    this.characterRepository,
    this.skillsRepository,
    this.equipmentRepository,
  ) : super(CharacterState());

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
        equipment: await _getCharacterEquipment(),
      );
    } else if (event is AddEquipmentItem) {
      characterRepository.addEquipmentToCharacter(character, event.equipment);

      final currentEquipment = state.equipment ?? [];
      currentEquipment.add(event.equipment);
      yield state.copyWith(equipment: currentEquipment);
    } else if (event is RemoveEquipmentItem) {
      characterRepository.removeEquipmentFromCharacter(character, event.equipment);

      final currentEquipment = state.equipment ?? [];
      currentEquipment.removeWhere((element) => element.index == event.equipment.index);
      yield state.copyWith(equipment: currentEquipment);
    }
  }

  Future<List<Equipment>> _getCharacterEquipment() async {
    final equipmentIndexes = characterRepository.getCharacterEquipmentIndexes(character);
    final allEquipment = await equipmentRepository.getEquipment();
    return equipmentIndexes.map((index) {
      return allEquipment.firstWhere((element) => element.index == index);
    }).toList();
  }
}
