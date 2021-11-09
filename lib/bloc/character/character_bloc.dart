import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/bloc/character/proficiency_bonus_table.dart';
import 'package:dnd_player_flutter/bloc/character/unarmed_attack.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/data/skills.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:meta/meta.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;
  final SkillsRepository skillsRepository;
  final EquipmentRepository equipmentRepository;
  final SpellsRepository spellsRepository;

  late Character character;

  CharacterBloc(
    this.characterRepository,
    this.skillsRepository,
    this.equipmentRepository,
    this.spellsRepository,
  ) : super(CharacterState()) {
    on<CharacterEvent>((event, emit) async {
      emit(await processEvent(event));
    });
  }

  Future<CharacterState> processEvent(CharacterEvent event) async {
    if (event is SetCharacter) {
      character = event.character;

      return CharacterState(
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
          equippedItems: await _getEquippedItems(),
          preparedSpells: await _getPreparedSpells(),
          learnedSpells: await _getLearnedSpells());
    } else if (event is AddEquipmentItem) {
      characterRepository.addEquipmentToCharacter(character, event.equipment);

      final currentEquipment = state.equipment ?? [];
      currentEquipment.add(event.equipment);
      return state.copyWith(equipment: currentEquipment);
    } else if (event is RemoveEquipmentItem) {
      characterRepository.removeEquipmentFromCharacter(
          character, event.equipment);

      final currentEquipment = state.equipment ?? [];
      currentEquipment
          .removeWhere((element) => element.index == event.equipment.index);
      return state.copyWith(equipment: currentEquipment);
    } else if (event is EquipItem) {
      characterRepository.equipItem(character, event.equipment);

      final currentEquippedItems = state.equippedItems ?? [];
      return state.copyWith(
        equippedItems: currentEquippedItems..add(event.equipment),
      );
    } else if (event is UnequipItem) {
      characterRepository.unequipItem(character, event.equipment);

      final currentEquippedItems = state.equippedItems ?? [];
      return state.copyWith(
        equippedItems: currentEquippedItems
          ..removeWhere((element) => element.index == event.equipment.index),
      );
    } else if (event is UpdateSpells) {
      characterRepository.updatePreparedSpells(character, event.preparedSpells);
      characterRepository.updateLearnedSpells(character, event.learnedSpells);

      return state.copyWith(
        preparedSpells: event.preparedSpells,
        learnedSpells: event.learnedSpells,
      );
    }

    return state;
  }

  Future<List<Equipment>> _getCharacterEquipment() async {
    final equipmentIndexes =
        characterRepository.getCharacterEquipmentIndexes(character);
    final allEquipment = await equipmentRepository.getEquipment();
    return equipmentIndexes.map((index) {
      return allEquipment.firstWhere((element) => element.index == index);
    }).toList();
  }

  Future<List<Equipment>> _getEquippedItems() async {
    final equippedItemsIndexes =
        characterRepository.getCharacterEquippedItemsIndexes(character);
    final allEquipment = await equipmentRepository.getEquipment();
    return equippedItemsIndexes.map((index) {
      return allEquipment.firstWhere((element) => element.index == index);
    }).toList();
  }

  Future<List<Spell>> _getLearnedSpells() async {
    final learnedSpellsIndexes =
        characterRepository.getLearnedSpellsIndexes(character);
    final allSpells = await spellsRepository.getSpells();

    return learnedSpellsIndexes
        .map((spellIndex) =>
            allSpells.firstWhere((element) => element.index == spellIndex))
        .toList();
  }

  Future<List<Spell>> _getPreparedSpells() async {
    final preparedSpellsIndexes =
        characterRepository.getPreparedSpellsIndexes(character);
    final allSpells = await spellsRepository.getSpells();

    return preparedSpellsIndexes
        .map((spellIndex) =>
            allSpells.firstWhere((element) => element.index == spellIndex))
        .toList();
  }
}
