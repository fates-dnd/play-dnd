import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/bloc/manage_traits_and_features/manage_traits_and_features_bloc.dart';
import 'package:dnd_player_flutter/dto/user_feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ManageFeatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => ManageTraitsAndFeaturesBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.add_feature),
        ),
        body: Column(
          children: [
            _Form(),
            _Button(),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: localizations.name,
              ),
              onChanged: (value) =>
                  BlocProvider.of<ManageTraitsAndFeaturesBloc>(context)
                      .add(OnNameChanged(value)),
            ),
            SizedBox(height: 32),
            TextField(
              minLines: 2,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: localizations.description,
              ),
              onChanged: (value) =>
                  BlocProvider.of<ManageTraitsAndFeaturesBloc>(context)
                      .add(OnDescriptionChanged(value)),
            ),
            SizedBox(height: 32),
            _UsagesSection(),
          ],
        ),
      ),
    );
  }
}

class _UsagesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            Text(
              localizations.usages + ": ",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 16),
            Container(
              width: 80,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: localizations.usages),
              ),
            )
          ],
        ),
        SizedBox(height: 16),
        _ShortLongRestSwitch(),
      ],
    );
  }
}

class _ShortLongRestSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShortLongRestSwitchState();
  }
}

class _ShortLongRestSwitchState extends State<_ShortLongRestSwitch> {
  String? _groupValue;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            localizations.resets_on + ": ",
            style: TextStyle(fontSize: 16),
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Radio<String>(
                  value: "short",
                  groupValue: _groupValue,
                  onChanged: (value) => setState(
                    () => _groupValue = value,
                  ),
                ),
                Text(
                  localizations.short_rest,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: "long",
                  groupValue: _groupValue,
                  onChanged: (value) => setState(
                    () => _groupValue = value,
                  ),
                ),
                Text(
                  localizations.long_rest,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageTraitsAndFeaturesBloc,
        ManageTraitsAndFeaturesState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(bottom: 24, top: 16),
        child: TextButton(
          onPressed: state.isSaveable
              ? () {
                  BlocProvider.of<CharacterBloc>(context)
                      .add(AddUserFeature(UserFeature(
                          name: state.name ?? "",
                          description: state.description ?? "",
                          usage: state.usages != null
                              ? Usage(
                                  state.usages ?? 0,
                                  state.resetsOn,
                                )
                              : null)));
                }
              : null,
          child: Text(AppLocalizations.of(context)!.add),
        ),
      ),
    );
  }
}
