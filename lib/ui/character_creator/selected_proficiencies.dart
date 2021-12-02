import 'package:dnd_player_flutter/bloc/character_creator/selected_proficiencies/selected_proficiencies_bloc.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
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
              itemBuilder: (context, index) {
                return ProficiencyOptionRow(
                  selectedSkill: state.selected[index],
                  availableOptions: state.available,
                );
              }),
        ),
      ),
    );
  }
}

class ProficiencyOptionRow extends StatelessWidget {
  final Skill? selectedSkill;
  final List<Skill> availableOptions;

  const ProficiencyOptionRow({
    Key? key,
    required this.selectedSkill,
    required this.availableOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        items: availableOptions
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.name),
                ))
            .toList());
  }
}
