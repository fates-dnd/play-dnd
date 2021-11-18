part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class UpdateLanguageCode extends SettingsEvent {
  final String newLanguageCode;

  UpdateLanguageCode(this.newLanguageCode);
}
