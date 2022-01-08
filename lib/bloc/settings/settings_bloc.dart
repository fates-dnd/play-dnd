import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repository;

  SettingsBloc(this.repository) : super(SettingsState(null)) {
    on((event, emit) async {
      if (event is InitSettings) {
        final language = await repository.getLanguage();
        emit(SettingsState(language));
      } else if (event is UpdateLanguageCode) {
        repository.setLanguage(event.newLanguageCode);
        emit(SettingsState(event.newLanguageCode));
      }
    });
  }
}
