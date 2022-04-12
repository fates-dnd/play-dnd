import 'package:dnd_player_flutter/bloc/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        children: [
          _SettingsTitle(title: localizations!.language),
          SizedBox(
            height: 8,
          ),
          _LanguageOption(
              title: "English",
              code: "en",
              onPress: () {
                BlocProvider.of<SettingsBloc>(context)
                    .add(UpdateLanguageCode("en"));
              }),
        ],
      ),
    );
  }
}

class _SettingsTitle extends StatelessWidget {
  final String title;

  const _SettingsTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final String code;
  final VoidCallback onPress;

  const _LanguageOption({
    Key? key,
    required this.title,
    required this.code,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return InkWell(
          onTap: onPress,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                state.languageCode == code
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 24,
                      )
                    : SizedBox(width: 24),
                SizedBox(width: 16),
                Text(title, style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        );
      },
    );
  }
}
