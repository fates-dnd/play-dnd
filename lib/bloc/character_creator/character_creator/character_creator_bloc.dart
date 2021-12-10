import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:dnd_player_flutter/dto/trait.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:meta/meta.dart';

part 'character_creator_event.dart';
part 'character_creator_state.dart';

class CharacterCreatorBloc
    extends Bloc<CharacterCreatorEvent, CharacterCreatorState> {
  final CharacterRepository repository;

  CharacterCreatorBloc(this.repository) : super(CharacterCreatorState()) {
    on<CharacterCreatorEvent>((event, emit) async {
      emit(await processEvent(event));
    });
  }

  Future<CharacterCreatorState> processEvent(
      CharacterCreatorEvent event) async {
    if (event is SubmitRace) {
      return state.copyWith(
        race: event.race,
        traits: event.traits,
      );
    } else if (event is SubmitClass) {
      return state.copyWith(clazz: event.clazz);
    } else if (event is SubmitBonusCharacteristics) {
      return state.copyWith(bonusCharacteristic: event.bonusCharacteristics);
    } else if (event is SubmitCharacteristics) {
      return state.copyWith(
        name: event.name,
        strength: event.strength,
        dexterity: event.dexterity,
        constitution: event.constitution,
        intelligence: event.intelligence,
        wisdom: event.wisdom,
        charisma: event.charisma,
      );
    } else if (event is SubmitSelectedProficiencies) {
      return state.copyWith(
        selectedProficiencies: event.proficiencies,
      );
    } else if (event is SaveCharacter) {
      final characterToSave = state
          .copyWith(selectedEquipment: _generateSelectedEquipment())
          .toCharacter();
      if (characterToSave != null) {
        repository.insertCharacter(characterToSave);
      }
    }

    return state;
  }

  List<EquipmentQuantity> _generateSelectedEquipment() {
    final clazz = state.clazz;

    final equipment = clazz?.startingEquipment ?? [];
    clazz?.equipmentChoices?.forEach((element) {
      if (element.options.length <= 1) {
        equipment.addAll(element.options);
        return;
      }
      equipment.addAll(element.options.sublist(0, element.choose));
    });

    return equipment;
  }
}
