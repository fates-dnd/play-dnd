import 'package:dnd_player_flutter/bloc/ability_score_improvement_dialog/ability_score_improvement_bloc.dart';
import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AbilityScoreImprovementDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final bloc = AbilityScoreImprovementBloc();
    return BlocProvider<AbilityScoreImprovementBloc>(
      create: (context) => bloc,
      child: AlertDialog(
        title: Text(localization.ability_score_improvement),
        content: BlocBuilder<AbilityScoreImprovementBloc,
            AbilityScoreImprovementState>(
          builder: (context, state) => Container(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<Characteristic>(
                hint: Text(
                  localization.improvement_option_1,
                  style: TextStyle(color: Colors.white60),
                ),
                value: state.option1,
                dropdownColor: theme.primaryColorLight,
                items: Characteristic.values.map((characteristic) {
                  return DropdownMenuItem<Characteristic>(
                    value: characteristic,
                    child: OptionItem(
                      characteristic: characteristic,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  bloc.add(SetImprovementOption1(value));
                },
              ),
              DropdownButton<Characteristic>(
                hint: Text(
                  localization.improvement_option_2,
                  style: TextStyle(color: Colors.white60),
                ),
                value: state.option2,
                dropdownColor: theme.primaryColorLight,
                items: Characteristic.values.map((characteristic) {
                  return DropdownMenuItem<Characteristic>(
                    value: characteristic,
                    child: OptionItem(
                      characteristic: characteristic,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  bloc.add(SetImprovementOption2(value));
                },
              ),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: Size.fromHeight(40)),
                onPressed: bloc.state.isPopulated
                    ? () {
                        BlocProvider.of<CharacterBloc>(context).add(
                            ImproveAbilityScores(
                                bloc.state.option1!, bloc.state.option2!));

                        Navigator.of(context).pop();
                      }
                    : null,
                child: Text(localization.done),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class OptionItem extends StatelessWidget {
  final Characteristic characteristic;

  const OptionItem({Key? key, required this.characteristic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      characteristic.getName(context),
      style: TextStyle(color: Colors.white),
    );
  }
}
