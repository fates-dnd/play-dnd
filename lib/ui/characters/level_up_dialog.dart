import 'package:dnd_player_flutter/bloc/character/ability_score_improvements.dart';
import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/bloc/level_up_dialog/level_up_dialog_bloc.dart';
import 'package:dnd_player_flutter/ui/characters/ability_score_improvement_dialog.dart';
import 'package:dnd_player_flutter/ui/common/slider_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LevelUpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final character = BlocProvider.of<CharacterBloc>(context).state;
    final hitDie = character.clazz?.hitDie;
    final currentLevel = character.level;
    final offerImprovements =
        shouldOfferAbilityScoreImprovement(currentLevel + 1);

    return BlocProvider(
      create: (context) => LevelUpDialogBloc(),
      child: AlertDialog(
        title: Center(
          child: Text(
            localizations.level_up,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
        ),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localizations.congrats_for_leveling_up(currentLevel + 1),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),
              _HitPointImprovementSection(hitDie: hitDie ?? 0),
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
              SizedBox(height: 4),
              Text(
                localizations.add_new_features_on_traits_and_features_page,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HitPointImprovementSection extends StatelessWidget {
  final int hitDie;

  const _HitPointImprovementSection({
    Key? key,
    required this.hitDie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.improved_hp,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Text(
                localizations.hit_die + ": d$hitDie",
                style: TextStyle(fontSize: 16, color: Colors.white60),
              ),
            ],
          ),
        ),
        SizedBox(width: 18),
        Expanded(
          child: SizedBox(
            height: 126,
            width: 30,
            child: SliderSelector(
              onItemChanged: (value) =>
                  BlocProvider.of<LevelUpDialogBloc>(context)
                      .add(SetNewHp(value)),
              children: List.generate(
                  hitDie,
                  (index) => BlocBuilder<LevelUpDialogBloc, LevelUpDialogState>(
                        builder: (context, state) => Text(
                          "${(index + 1)}",
                          style: TextStyle(
                            fontSize: index == state.newHp ? 32 : 24,
                            fontWeight: index == state.newHp
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: index == state.newHp
                                ? Colors.white
                                : Colors.white30,
                          ),
                        ),
                      )),
              itemExtent: 42,
              totalHeight: 120,
            ),
          ),
        ),
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
      onPressed: () {
        final newHp = BlocProvider.of<LevelUpDialogBloc>(context).state.newHp;
        BlocProvider.of<CharacterBloc>(context).add(LevelUpWithHp(newHp + 1));

        Navigator.of(context).pop();

        showDialog(
            context: context,
            builder: (context) => AbilityScoreImprovementDialog());
      },
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
      onPressed: () {
        final newHp = BlocProvider.of<LevelUpDialogBloc>(context).state.newHp;
        BlocProvider.of<CharacterBloc>(context).add(LevelUpWithHp(newHp + 1));

        Navigator.of(context).pop();
      },
      child: Text(localizations.done),
    );
  }
}
