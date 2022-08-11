import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_ability_scores_event.dart';
part 'manage_ability_scores_state.dart';

class ManageAbilityScoresBloc
    extends Bloc<ManageAbilityScoresEvent, ManageAbilityScoresState> {
  ManageAbilityScoresBloc() : super(ManageAbilityScoresState()) {
    on((event, emit) {
      switch ((event as ManageAbilityScoresEvent).characteristic) {
        case Characteristic.STRENGTH:
          emit(state.copyWithStregth(event.newValue));
          break;
        case Characteristic.DEXTERITY:
          emit(state.copyWithDexterity(event.newValue));
          break;
        case Characteristic.CONSTITUTION:
          emit(state.copyWithConstitution(event.newValue));
          break;
        case Characteristic.INTELLIGENCE:
          emit(state.copyWithIntelligence(event.newValue));
          break;
        case Characteristic.WISDOM:
          emit(state.copyWithWisdom(event.newValue));
          break;
        case Characteristic.CHARISMA:
          emit(state.copyWithCharisma(event.newValue));
          break;
      }
    });
  }
}
