import 'package:dnd_player_flutter/bloc/character_creator/selected_proficiencies/selected_proficiencies_bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';

void main() {
  final proficiencyChoices = ProficiencyChoices(2, [
    Skill("index1", "name1", Characteristic.STRENGTH),
    Skill("index2", "name2", Characteristic.DEXTERITY),
    Skill("index3", "name3", Characteristic.CHARISMA),
  ]);

  final clazz = Class(
    "index",
    "name",
    [], // saving throws
    null, // spellcasting ability
    proficiencyChoices,
  );

  test('initial state has all options available.', () {
    final bloc = SelectedProficienciesBloc(clazz);
    expect(
        bloc.state,
        SelectedProficienciesState(
          2, // choose
          [null, null],
          [
            proficiencyChoices.options,
            proficiencyChoices.options,
          ],
        ));
  });

  blocTest<SelectedProficienciesBloc, SelectedProficienciesState>(
    'updates available optins when SelecSkillProficiency is emitted.',
    build: () => SelectedProficienciesBloc(clazz),
    act: (bloc) => bloc.add(SelectSkillProficiency(
        0, Skill("index1", "name1", Characteristic.STRENGTH))),
    expect: () => <SelectedProficienciesState>[
      SelectedProficienciesState(
        2, // choose
        [Skill("index1", "name1", Characteristic.STRENGTH), null],
        [
          [
            Skill("index1", "name1", Characteristic.STRENGTH),
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
          ],
          [
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
          ],
        ],
      )
    ],
  );

  blocTest<SelectedProficienciesBloc, SelectedProficienciesState>(
    'updates available optins when SelecSkillProficiency is emitted for multiple choices.',
    build: () => SelectedProficienciesBloc(clazz),
    act: (bloc) {
      bloc.add(SelectSkillProficiency(
          0, Skill("index1", "name1", Characteristic.STRENGTH)));
      bloc.add(SelectSkillProficiency(
          1, Skill("index2", "name2", Characteristic.DEXTERITY)));
    },
    expect: () => <SelectedProficienciesState>[
      SelectedProficienciesState(
        2, // choose
        [
          Skill("index1", "name1", Characteristic.STRENGTH),
          null,
        ],
        [
          [
            Skill("index1", "name1", Characteristic.STRENGTH),
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
          ],
          [
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
          ],
        ],
      ),
      SelectedProficienciesState(
        2, // choose
        [
          Skill("index1", "name1", Characteristic.STRENGTH),
          Skill("index2", "name2", Characteristic.DEXTERITY),
        ],
        [
          [
            Skill("index1", "name1", Characteristic.STRENGTH),
            Skill("index3", "name3", Characteristic.CHARISMA),
          ],
          [
            Skill("index2", "name2", Characteristic.DEXTERITY),
            Skill("index3", "name3", Characteristic.CHARISMA),
          ],
        ],
      )
    ],
  );
}
