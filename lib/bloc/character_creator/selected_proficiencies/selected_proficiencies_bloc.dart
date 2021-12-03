import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'selected_proficiencies_event.dart';
part 'selected_proficiencies_state.dart';

class SelectedProficienciesBloc
    extends Bloc<SelectedProficienciesEvent, SelectedProficienciesState> {
  final Class clazz;

  SelectedProficienciesBloc(this.clazz)
      : super(SelectedProficienciesState(
          clazz.proficiencyChoices.choose,
          List.generate(clazz.proficiencyChoices.choose, (index) => null),
          List.generate(clazz.proficiencyChoices.choose,
              (index) => List.of(clazz.proficiencyChoices.options)),
        )) {
    on<SelectedProficienciesEvent>((event, emit) {
      if (event is SelectSkillProficiency) {
        final selected = List.of(state.selected);
        selected[event.index] = event.skill;

        final available =
            List.generate(clazz.proficiencyChoices.choose, (index) {
          return List.of(clazz.proficiencyChoices.options)
            ..removeWhere((element) =>
                (List.of(selected)..removeAt(index)).contains(element));
        });

        emit(SelectedProficienciesState(
          state.choose,
          selected,
          available,
        ));
      }
    });
  }
}
