import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ability_score_improvement_event.dart';
part 'ability_score_improvement_state.dart';

class AbilityScoreImprovementBloc
    extends Bloc<AbilityScoreImprovementEvent, AbilityScoreImprovementState> {
  AbilityScoreImprovementBloc() : super(AbilityScoreImprovementState()) {
    on((event, emit) {
      if (event is SetImprovementOption1) {
        emit(AbilityScoreImprovementState(
          option1: event.characteristic,
          option2: state.option2,
        ));
      } else if (event is SetImprovementOption2) {
        emit(AbilityScoreImprovementState(
          option1: state.option1,
          option2: event.characteristic,
        ));
      }
    });
  }
}
