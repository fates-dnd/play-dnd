import 'package:dnd_player_flutter/dto/rest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_traits_and_features_event.dart';
part 'manage_traits_and_features_state.dart';

class ManageTraitsAndFeaturesBloc
    extends Bloc<ManageTraitsAndFeaturesEvent, ManageTraitsAndFeaturesState> {
  ManageTraitsAndFeaturesBloc() : super(ManageTraitsAndFeaturesState()) {
    on<ManageTraitsAndFeaturesEvent>((event, emit) {
      if (event is OnNameChanged) {
        emit(state.updateNameOrDescription(name: event.name));
      } else if (event is OnDescriptionChanged) {
        emit(state.updateNameOrDescription(description: event.description));
      } else if (event is OnUsagesChanged) {
        emit(state.updateUsages(event.usages));
      } else if (event is OnResetsOnChanged) {
        emit(state.updateResetsOn(event.resetsOn));
      }
    });
  }
}
