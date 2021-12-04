import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'selected_proficiencies_event.dart';
part 'selected_proficiencies_state.dart';

class SelectedProficienciesBloc
    extends Bloc<SelectedProficienciesEvent, SelectedProficienciesState> {
  static const int BACKGROUND_OPTIONS = 2;

  final SettingsRepository settingsRepository;
  final SkillsRepository skillsRepository;
  final Class clazz;

  SelectedProficienciesBloc(
    this.settingsRepository,
    this.skillsRepository,
    this.clazz,
  ) : super(SelectedProficienciesState()) {
    on<SelectedProficienciesEvent>((event, emit) async {
      final language = settingsRepository.getLanguage();
      final allSkills = await skillsRepository.getSkills(language);
      if (event is LoadSkills) {
        emit(SelectedProficienciesState(
          choose: clazz.proficiencyChoices.choose,
          chooseForBackground: BACKGROUND_OPTIONS,
          selected: List.generate(
              clazz.proficiencyChoices.choose + BACKGROUND_OPTIONS,
              (index) => null),
          available: List.generate(
              clazz.proficiencyChoices.choose + BACKGROUND_OPTIONS, (index) {
            if (index < clazz.proficiencyChoices.choose) {
              return List.of(clazz.proficiencyChoices.options);
            } else {
              return allSkills;
            }
          }),
        ));
      } else if (event is SelectSkillProficiency) {
        final selected = List.of(state.selected);
        selected[event.index] = event.skill;

        final available = List.generate(
            clazz.proficiencyChoices.choose + BACKGROUND_OPTIONS, (index) {
          var source = <Skill>[];
          if (index < clazz.proficiencyChoices.choose) {
            source = clazz.proficiencyChoices.options;
          } else {
            source = allSkills;
          }

          return List.of(source)
            ..removeWhere((element) =>
                (List.of(selected)..removeAt(index)).contains(element));
        });

        emit(SelectedProficienciesState(
          choose: state.choose,
          chooseForBackground: BACKGROUND_OPTIONS,
          selected: selected,
          available: available,
        ));
      }
    });
  }
}
