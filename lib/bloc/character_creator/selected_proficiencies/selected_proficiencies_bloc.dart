import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
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
          clazz.proficiencyChoices.options,
        )) {
    on<SelectedProficienciesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
