import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  String? languageCode;

  SettingsBloc() : super(SettingsState(null)) {
    on((event, emit) {
      if (event is UpdateLanguageCode) {
        languageCode = event.newLanguageCode;
        emit(SettingsState(languageCode));
      }
    });
  }
}
