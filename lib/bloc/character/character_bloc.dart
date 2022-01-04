import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/bloc/character/proficiency_bonus_table.dart';
import 'package:dnd_player_flutter/bloc/character/spell_slots.dart';
import 'package:dnd_player_flutter/bloc/character/unarmed_attack.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/data/skills.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/currency.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/dto/equipment_property.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:dnd_player_flutter/rules/spellcasting/spellcasting.dart';
import 'package:dnd_player_flutter/utils.dart';
import 'package:meta/meta.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final SettingsRepository settingsRepository;
  final CharacterRepository characterRepository;
  final SkillsRepository skillsRepository;
  final EquipmentRepository equipmentRepository;
  final SpellsRepository spellsRepository;

  late Character character;
  late Spellcasting? spellcasting;

  CharacterBloc(
    this.settingsRepository,
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
      spellcasting = Spellcasting.createForClass(character.clazz);

      return CharacterState(
        level: character.level,
        maxHp: character.maxHp,
        hp: character.hp,
        strength: character.baseStrength,
        dexterity: character.baseDexterity,
        constitution: character.baseConstitution,
        intelligence: character.baseIntelligence,
        wisdom: character.baseWisdom,
        charisma: character.baseCharisma,
        race: character.race,
        clazz: character.clazz,
        skills:
            await skillsRepository.getSkills(settingsRepository.getLanguage()),
        proficienctSkills: await _getProficientSkills(),
        equipment: await _getCharacterEquipment(),
        preparedSpells: await _getPreparedSpells(),
        learnedSpells: await _getLearnedSpells(),
        levelSpellSlots: await getSpellSlots(),
        money: await getMoney(),
      );
    } else if (event is AddEquipmentItem) {
      characterRepository.addEquipmentToCharacter(character, event.equipment);

      final currentEquipment = state.equipment ?? [];
      final equipmentIndex = currentEquipment.indexWhere(
          (element) => element.equipment.index == event.equipment.index);
      if (!event.equipment.isStackable || equipmentIndex == -1) {
        currentEquipment.add(EquipmentQuantity(event.equipment, 1, false));
        return state.copyWith(equipment: currentEquipment);
      }

      final equipmentQuantity = currentEquipment[equipmentIndex];
      currentEquipment[equipmentIndex] = EquipmentQuantity(
        event.equipment,
        equipmentQuantity.quantity + 1,
        equipmentQuantity.isEquipped,
      );
      return state.copyWith(equipment: currentEquipment);
    } else if (event is RemoveEquipmentItem) {
      characterRepository.removeEquipmentFromCharacter(
          character, event.equipment);

      final currentEquipment = state.equipment ?? [];
      currentEquipment.remove(event.equipment);
      return state.copyWith(equipment: currentEquipment);
    } else if (event is EquipItem) {
      characterRepository.equipItem(character, event.equipment);

      final currentEquippedItems = state.equipment ?? [];
      final index = currentEquippedItems
          .indexWhere((element) => element == event.equipment);
      currentEquippedItems[index] = EquipmentQuantity(
        event.equipment.equipment,
        event.equipment.quantity,
        true,
      );
      return state.copyWith(
        equipment: currentEquippedItems,
      );
    } else if (event is UnequipItem) {
      characterRepository.unequipItem(character, event.equipment);

      final currentEquippedItems = state.equipment ?? [];
      final index = currentEquippedItems
          .indexWhere((element) => element == event.equipment);
      currentEquippedItems[index] = EquipmentQuantity(
        event.equipment.equipment,
        event.equipment.quantity,
        false,
      );
      return state.copyWith(
        equipment: currentEquippedItems,
      );
    } else if (event is UpdateSpells) {
      characterRepository.updatePreparedSpells(character, event.preparedSpells);
      characterRepository.updateLearnedSpells(character, event.learnedSpells);

      return state.copyWith(
        preparedSpells: event.preparedSpells,
        learnedSpells: event.learnedSpells,
      );
    } else if (event is UseSpellSlot) {
      characterRepository.useSpellSlot(character, event.spellLevel);
      return state.copyWith(levelSpellSlots: await getSpellSlots());
    } else if (event is UnuseSpellSlot) {
      characterRepository.unuseSpellSlot(character, event.spellLevel);
      return state.copyWith(levelSpellSlots: await getSpellSlots());
    } else if (event is Heal) {
      final newHp = (state.hp + event.amount).clamp(0, state.maxHp);
      characterRepository.setHp(character, newHp);
      return state.copyWith(hp: newHp);
    } else if (event is Damage) {
      final newHp = (state.hp - event.amount).clamp(0, state.maxHp);
      characterRepository.setHp(character, newHp);
      return state.copyWith(hp: newHp);
    } else if (event is EarnMoney) {
      characterRepository.earnMoney(
          character, event.currency.index, event.amount);
      return state.copyWith(
        money: await getMoney(),
      );
    } else if (event is SpendMoney) {
      characterRepository.spendMoney(
          character, event.currency.index, event.amount);
      return state.copyWith(
        money: await getMoney(),
      );
    }

    return state;
  }

  Future<List<Skill>> _getProficientSkills() async {
    final language = settingsRepository.getLanguage();
    final allSkills = await skillsRepository.getSkills(language);
    final skillIndexes =
        characterRepository.getProficientSkillIndexes(character);
    return skillIndexes
        .map((e) => allSkills.firstWhere((element) => element.index == e))
        .toList();
  }

  Future<List<EquipmentQuantity>> _getCharacterEquipment() async {
    final equipmentIndexQuantities =
        characterRepository.getCharacterEquipmentIndexQuantities(character);
    final language = settingsRepository.getLanguage();
    final allEquipment = await equipmentRepository.getEquipment(language);
    return equipmentIndexQuantities.map((indexQuantity) {
      final equipment = allEquipment
          .firstWhere((element) => element.index == indexQuantity.index);
      return EquipmentQuantity(
          equipment, indexQuantity.quantity, indexQuantity.isEquipped);
    }).toList();
  }

  Future<List<Spell>> _getLearnedSpells() async {
    final language = settingsRepository.getLanguage();
    final learnedSpellsIndexes =
        characterRepository.getLearnedSpellsIndexes(character);
    final allSpells = await spellsRepository.getSpells(language);

    return learnedSpellsIndexes
        .map((spellIndex) =>
            allSpells.firstWhere((element) => element.index == spellIndex))
        .toList();
  }

  Future<List<Spell>> _getPreparedSpells() async {
    final preparedSpellsIndexes =
        characterRepository.getPreparedSpellsIndexes(character);
    final language = settingsRepository.getLanguage();
    final allSpells = await spellsRepository.getSpells(language);

    final result = preparedSpellsIndexes
        .map((spellIndex) =>
            allSpells.firstWhere((element) => element.index == spellIndex))
        .toList();
    result.sort((left, right) => left.level.compareTo(right.level));

    return result;
  }

  Future<Map<int, SpellSlots>?> getSpellSlots() async {
    final spellSlotsForLevel =
        spellcasting?.getSpellSlotsForLevel(character.level);
    final usedSpellSlots =
        await characterRepository.getUsedSpellSlots(character);
    return spellSlotsForLevel?.map((key, value) {
      return MapEntry(
        key,
        SpellSlots(usedSpellSlots[key] ?? 0, value),
      );
    });
  }

  Future<Map<Currency, int>?> getMoney() async {
    final rawMoney = await characterRepository.getMoney(character);
    return rawMoney.map((key, value) {
      return MapEntry(Currency.values[key], value);
    });
  }
}
