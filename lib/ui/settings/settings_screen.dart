import 'package:dnd_player_flutter/bloc/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.languages)),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        children: [
          _LanguageOption(
              title: "English",
              onPress: () {
                BlocProvider.of<SettingsBloc>(context)
                    .add(UpdateLanguageCode("en"));
              }),
          SizedBox(height: 12),
          _LanguageOption(
              title: "Русский",
              onPress: () {
                BlocProvider.of<SettingsBloc>(context)
                    .add(UpdateLanguageCode("ru"));
              }),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final VoidCallback onPress;

  const _LanguageOption({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
