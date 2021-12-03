import 'package:dnd_player_flutter/bloc/character_creator/selected_proficiencies/selected_proficiencies_bloc.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
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
      create: (context) => SelectedProficienciesBloc(clazz),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.skills),
          elevation: 0,
        ),
        body:
            BlocBuilder<SelectedProficienciesBloc, SelectedProficienciesState>(
          builder: (context, state) => ListView.builder(
              itemCount: state.choose,
              padding: EdgeInsets.only(top: 32),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ProficiencyOptionRow(
                    index: index,
                    selectedSkill: state.selected[index],
                    availableOptions: List.of(state.available[index]),
                  ),
                );
              }),
        ),
      ),
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

    return Center(
      child: DropdownButton<Skill>(
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
      ),
    );
  }
}
