import 'package:bloc_test/bloc_test.dart';
import 'package:dnd_player_flutter/bloc/character_creator/character_creator/character_creator_bloc.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:dnd_player_flutter/dto/trait.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'character_creator_bloc_test.mocks.dart';

@GenerateMocks([CharacterRepository, Class, Race, Trait, Skill, Equipment])
void main() {
  final repository = MockCharacterRepository();

  final race = MockRace();
  final clazz = MockClass();
  final skill = MockSkill();

  void _submitAllStepsForBloc(CharacterCreatorBloc bloc) {
    bloc.add(SubmitRace(race, [MockTrait()]));
    bloc.add(SubmitClass(clazz));
    bloc.add(SubmitCharacteristics(
      "Name",
      4, // strength
      5, // dexterity
      10, // constitution
      7, // intelligence
      8, // wisdom
      9, // charisma
    ));
    bloc.add(SubmitSelectedProficiencies([skill]));
    bloc.add(SaveCharacter());
  }

  final startingEquipment =
      List.generate(5, (index) => EquipmentQuantity(MockEquipment(), 1, false));

  blocTest<CharacterCreatorBloc, CharacterCreatorState>(
    "character creation works fine with all steps completed with only starting equipment",
    setUp: () {
      when(clazz.startingEquipment).thenReturn(startingEquipment);
      when(clazz.equipmentChoices).thenReturn([]);
      when(clazz.hitDie).thenReturn(10);
    },
    build: () => CharacterCreatorBloc(repository),
    act: _submitAllStepsForBloc,
    verify: (_) {
      verify(repository.insertCharacter(Character(
        "Name",
        1, // level
        10, // max hp
        10, // hp
        4,
        5,
        10, // constitution
        7,
        8,
        9,
        race,
        clazz,
        [skill],
        startingEquipment,
      )));
    },
  );

  final knife = EquipmentQuantity(MockEquipment(), 1, false);
  final sword = EquipmentQuantity(MockEquipment(), 1, false);
  final dart = EquipmentQuantity(MockEquipment(), 1, false);
  final bow = EquipmentQuantity(MockEquipment(), 1, false);

  blocTest<CharacterCreatorBloc, CharacterCreatorState>(
    "character creation works fine with all steps completed with starting equipment options",
    setUp: () {
      when(clazz.startingEquipment).thenReturn([]);
      when(clazz.equipmentChoices).thenReturn([
        EquipmentChoices(1, [knife, sword]),
        EquipmentChoices(1, [dart, bow]),
      ]);
    },
    build: () => CharacterCreatorBloc(repository),
    act: _submitAllStepsForBloc,
    verify: (_) {
      verify(repository.insertCharacter(Character(
        "Name",
        1, // level
        10, // max hp
        10, // hp
        4,
        5,
        10, // constitution
        7,
        8,
        9,
        race,
        clazz,
        [skill],
        [knife, dart],
      )));
    },
  );
}
