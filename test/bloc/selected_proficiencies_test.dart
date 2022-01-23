import 'package:dnd_player_flutter/bloc/character_creator/selected_proficiencies/selected_proficiencies_bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:test/fake.dart';

void main() {
  final settingsRepository = FakeSettingsRepository("en");
  final skillsRepository = FakeSkillsRepository();

  final proficiencyChoices = ProficiencyChoices(2, [
    Skill("index1", "name1", Characteristic.STRENGTH),
    Skill("index2", "name2", Characteristic.DEXTERITY),
    Skill("index3", "name3", Characteristic.CHARISMA),
  ]);

  final clazz = Class(
    "index",
    "name",
    10, // hit die
    [], // saving throws
    null, // spellcasting ability
    proficiencyChoices,
    [],
    [],
    [],
  );

  final defaultState =
      SelectedProficienciesState(choose: 2, chooseForBackground: 2, selected: [
    null,
    null,
    null,
    null
  ], available: [
    [
      Skill("index1", "name1", Characteristic.STRENGTH),
      Skill("index2", "name2", Characteristic.DEXTERITY),
      Skill("index3", "name3", Characteristic.CHARISMA),
    ],
    [
      Skill("index1", "name1", Characteristic.STRENGTH),
      Skill("index2", "name2", Characteristic.DEXTERITY),
      Skill("index3", "name3", Characteristic.CHARISMA),
    ],
    [
      Skill("index1", "name1", Characteristic.STRENGTH),
      Skill("index2", "name2", Characteristic.DEXTERITY),
      Skill("index3", "name3", Characteristic.CHARISMA),
      Skill("index4", "name4", Characteristic.INTELLIGENCE),
      Skill("index5", "name5", Characteristic.WISDOM),
      Skill("index6", "name6", Characteristic.DEXTERITY),
    ],
    [
      Skill("index1", "name1", Characteristic.STRENGTH),
      Skill("index2", "name2", Characteristic.DEXTERITY),
      Skill("index3", "name3", Characteristic.CHARISMA),
      Skill("index4", "name4", Characteristic.INTELLIGENCE),
      Skill("index5", "name5", Characteristic.WISDOM),
      Skill("index6", "name6", Characteristic.DEXTERITY),
    ],
  ]);

  blocTest<SelectedProficienciesBloc, SelectedProficienciesState>(
    'initial state when loading data',
    build: () =>
        SelectedProficienciesBloc(settingsRepository, skillsRepository, clazz),
    act: (bloc) => bloc.add(LoadSkills()),
    expect: () => <SelectedProficienciesState>[
      defaultState,
    ],
  );

  blocTest<SelectedProficienciesBloc, SelectedProficienciesState>(
    'updates available optins when SelecSkillProficiency is emitted.',
    build: () =>
        SelectedProficienciesBloc(settingsRepository, skillsRepository, clazz),
    act: (bloc) {
      bloc.add(LoadSkills());
      bloc.add(SelectSkillProficiency(
          0, Skill("index1", "name1", Characteristic.STRENGTH)));
    },
    expect: () => <SelectedProficienciesState>[
      defaultState,
      SelectedProficienciesState(
        choose: 2,
        chooseForBackground: 2,
        selected: [
          Skill("index1", "name1", Characteristic.STRENGTH),
          null,
          null,
          null
        ],
        available: [
          [
            Skill("index1", "name1", Characteristic.STRENGTH),
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
          ],
          [
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
          ],
          [
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
            Skill("index4", "name4", Characteristic.INTELLIGENCE),
            Skill("index5", "name5", Characteristic.WISDOM),
            Skill("index6", "name6", Characteristic.DEXTERITY),
          ],
          [
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
            Skill("index4", "name4", Characteristic.INTELLIGENCE),
            Skill("index5", "name5", Characteristic.WISDOM),
            Skill("index6", "name6", Characteristic.DEXTERITY),
          ],
        ],
      )
    ],
  );

  blocTest<SelectedProficienciesBloc, SelectedProficienciesState>(
    'updates available optins when SelecSkillProficiency is emitted for multiple choices.',
    build: () =>
        SelectedProficienciesBloc(settingsRepository, skillsRepository, clazz),
    act: (bloc) {
      bloc.add(LoadSkills());
      bloc.add(SelectSkillProficiency(
          0, Skill("index1", "name1", Characteristic.STRENGTH)));
      bloc.add(SelectSkillProficiency(
          1, Skill("index2", "name2", Characteristic.DEXTERITY)));
    },
    expect: () => <SelectedProficienciesState>[
      defaultState,
      SelectedProficienciesState(
        choose: 2,
        chooseForBackground: 2,
        selected: [
          Skill("index1", "name1", Characteristic.STRENGTH),
          null,
          null,
          null,
        ],
        available: [
          [
            Skill("index1", "name1", Characteristic.STRENGTH),
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
          ],
          [
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
          ],
          [
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
            Skill("index4", "name4", Characteristic.INTELLIGENCE),
            Skill("index5", "name5", Characteristic.WISDOM),
            Skill("index6", "name6", Characteristic.DEXTERITY),
          ],
          [
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
            Skill("index4", "name4", Characteristic.INTELLIGENCE),
            Skill("index5", "name5", Characteristic.WISDOM),
            Skill("index6", "name6", Characteristic.DEXTERITY),
          ],
        ],
      ),
      SelectedProficienciesState(
        choose: 2,
        chooseForBackground: 2,
        selected: [
          Skill("index1", "name1", Characteristic.STRENGTH),
          Skill("index2", "name2", Characteristic.DEXTERITY),
          null,
          null,
        ],
        available: [
          [
            Skill("index1", "name1", Characteristic.STRENGTH),
            Skill("index3", "name3", Characteristic.CHARISMA),
          ],
          [
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
          ],
          [
            Skill("index3", "name3", Characteristic.CHARISMA),
            Skill("index4", "name4", Characteristic.INTELLIGENCE),
            Skill("index5", "name5", Characteristic.WISDOM),
            Skill("index6", "name6", Characteristic.DEXTERITY),
          ],
          [
            Skill("index3", "name3", Characteristic.CHARISMA),
            Skill("index4", "name4", Characteristic.INTELLIGENCE),
            Skill("index5", "name5", Characteristic.WISDOM),
            Skill("index6", "name6", Characteristic.DEXTERITY),
          ],
        ],
      )
    ],
  );
}

class FakeSkillsRepository extends Fake implements SkillsRepository {
  @override
  Future<List<Skill>> getSkills(String language) async {
    return [
      Skill("index1", "name1", Characteristic.STRENGTH),
      Skill("index2", "name2", Characteristic.DEXTERITY),
      Skill("index3", "name3", Characteristic.CHARISMA),
      Skill("index4", "name4", Characteristic.INTELLIGENCE),
      Skill("index5", "name5", Characteristic.WISDOM),
      Skill("index6", "name6", Characteristic.DEXTERITY),
    ];
  }
}

class FakeSettingsRepository extends Fake implements SettingsRepository {
  final String language;

  FakeSettingsRepository(this.language);

  @override
  Future<String> getLanguage() async {
    return language;
  }
}
