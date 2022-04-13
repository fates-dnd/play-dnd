import 'package:dnd_player_flutter/dto/feature.dart';
import 'package:dnd_player_flutter/dto/trait.dart';
import 'package:dnd_player_flutter/repository/features_repository.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/traits_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'traits_and_features_event.dart';
part 'traits_and_features_state.dart';

class TraitsAndFeaturesBloc
    extends Bloc<TraitsAndFeaturesEvent, TraitsAndFeaturesState> {
  final SettingsRepository settingsRepository;
  final TraitsRepository traitsRepository;
  final FeaturesRepository featuresRepository;

  TraitsAndFeaturesBloc(
    this.settingsRepository,
    this.traitsRepository,
    this.featuresRepository,
  ) : super(TraitsAndFeaturesState([], [])) {
    on<TraitsAndFeaturesEvent>((event, emit) async {
      if (event is LoadTraitsAndFeatures) {
        final language = await settingsRepository.getLanguage();

        final traits = await traitsRepository.getTraits(language);
        final features = await featuresRepository.getFeatures(language);

        emit(TraitsAndFeaturesState(traits, features));
      }
    });
  }
}
