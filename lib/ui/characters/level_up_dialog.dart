import 'package:dnd_player_flutter/bloc/character/ability_score_improvements.dart';
import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LevelUpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Center(
        child: Text(
          localizations.level_up,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
      ),
      content: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          final offerImprovements =
              shouldOfferAbilityScoreImprovement(state.level + 1);
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  localizations.congrats_for_leveling_up(state.level + 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                _HitPointImprovementSection(),
                SizedBox(height: 24),
                offerImprovements
                    ? Column(
                        children: [
                          _AbilityScoreImprovementButton(),
                          SizedBox(height: 8),
                          _NewFeatButton(),
                        ],
                      )
                    : _DoneButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HitPointImprovementSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Text(localizations.improved_hp + ": ",
            style: TextStyle(fontSize: 18, color: Colors.white)),
        SizedBox(width: 18),
        Expanded(
            child: TextField(
          keyboardType: TextInputType.number,
        )),
      ],
    );
  }
}

class _AbilityScoreImprovementButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: Size.fromHeight(40)),
      onPressed: () {},
      child: Text(localizations.ability_score_improvement),
    );
  }
}

class _NewFeatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: Size.fromHeight(40)),
      onPressed: () {},
      child: Text(localizations.feat),
    );
  }
}

class _DoneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(40)),
      onPressed: () {},
      child: Text(localizations.done),
    );
  }
}
