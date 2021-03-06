import 'package:dnd_player_flutter/bloc/character_creator/character_creator/character_creator_bloc.dart';
import 'package:dnd_player_flutter/bloc/character_creator/selected_proficiencies/selected_proficiencies_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:dnd_player_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectedProficiencies extends StatelessWidget {
  final Class clazz;

  const SelectedProficiencies({
    Key? key,
    required this.clazz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectedProficienciesBloc(
        getIt<SettingsRepository>(),
        getIt<SkillsRepository>(),
        clazz,
      )..add(LoadSkills()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.skills),
          elevation: 0,
        ),
        body:
            BlocBuilder<SelectedProficienciesBloc, SelectedProficienciesState>(
                builder: (context, state) {
          var currentRowIndex = -1;
          return Column(
            children: [
              Expanded(
                child: ListView(
                    padding: EdgeInsets.only(top: 32, left: 32, right: 32),
                    children: state.selected.map<Widget>((e) {
                      currentRowIndex += 1;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ProficiencyOptionRow(
                          index: currentRowIndex,
                          selectedSkill: state.selected[currentRowIndex],
                          availableOptions:
                              List.of(state.available[currentRowIndex]),
                        ),
                      );
                    }).toList()
                      ..insert(
                          0,
                          DescriptionText(
                              description: AppLocalizations.of(context)!
                                  .skill_proficiencies_for_class))
                      ..insert(
                          state.choose + 1,
                          DescriptionText(
                              description: AppLocalizations.of(context)!
                                  .skill_proficiencies_for_background))
                      ..insert(state.choose + 1, SizedBox(height: 24))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 8.0),
                child: TextButton(
                    onPressed: state.areSkillsSelected
                        ? () {
                            final bloc =
                                BlocProvider.of<CharacterCreatorBloc>(context);
                            bloc.add(SubmitSelectedProficiencies(
                                state.selected.map((e) => e!).toList()));
                            bloc.add(SaveCharacter());
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil("/", (route) => false);
                          }
                        : null,
                    child: Text(AppLocalizations.of(context)!.select)),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  final String description;

  const DescriptionText({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(fontSize: 18),
    );
  }
}

class ProficiencyOptionRow extends StatelessWidget {
  final int index;
  final Skill? selectedSkill;
  final List<Skill> availableOptions;

  const ProficiencyOptionRow({
    Key? key,
    required this.index,
    required this.selectedSkill,
    required this.availableOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButton<Skill>(
      isExpanded: true,
      hint: Text(
        AppLocalizations.of(context)!.skill + " ${index + 1}",
        style: TextStyle(color: Color(0xFFA4A4A4), fontSize: 28),
      ),
      underline: SizedBox(),
      dropdownColor: theme.primaryColorLight,
      value: selectedSkill,
      items: availableOptions
          .map((e) => DropdownMenuItem<Skill>(
                value: e,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(e.name,
                      style: TextStyle(
                        color: e.characteristic.getColor(),
                        fontSize: 28,
                      )),
                ),
              ))
          .toList(),
      onChanged: (skill) {
        if (skill == null) {
          return;
        }

        BlocProvider.of<SelectedProficienciesBloc>(context)
            .add(SelectSkillProficiency(index, skill));
      },
    );
  }
}
