import 'package:bloc_test/bloc_test.dart';
import 'package:dnd_player_flutter/bloc/character_creator/character_creator/character_creator_bloc.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:dnd_player_flutter/dto/trait.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'character_creator_bloc_test.mocks.dart';

@GenerateMocks([CharacterRepository, Class, Race, Trait, Skill])
void main() {
  final repository = MockCharacterRepository();

  final race = MockRace();
  final clazz = MockClass();
  final skill = MockSkill();

  blocTest<CharacterCreatorBloc, CharacterCreatorState>(
    "character creation works fine with all steps completed",
    setUp: () {
      when(clazz.startingEquipment).thenReturn([]);
      when(clazz.equipmentChoices).thenReturn([]);
    },
    build: () => CharacterCreatorBloc(repository),
    act: (bloc) {
      bloc.add(SubmitRace(race, [MockTrait()]));
      bloc.add(SubmitClass(clazz));
      bloc.add(SubmitCharacteristics(
        "Name",
        4, // strength
        5, // dexterity
        6, // constitution
        7, // intelligence
        8, // wisdom
        9, // charisma
      ));
      bloc.add(SubmitSelectedProficiencies([skill]));
      bloc.add(SaveCharacter());
    },
    verify: (_) {
      verify(repository.insertCharacter(Character(
        "Name",
        1, // level
        4,
        5,
        6,
        7,
        8,
        9,
        race,
        clazz,
        [skill],
        [],
      )));
    },
  );
}
