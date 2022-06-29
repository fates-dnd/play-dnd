import 'package:dnd_player_flutter/bloc/character_creator/character_creator/character_creator_bloc.dart';
import 'package:dnd_player_flutter/bloc/character_creator/classes/classes_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/ui/character_creator/characteristics_bonus.dart';
import 'package:dnd_player_flutter/ui/character_creator/set_characteristics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClassesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClassesBloc>(
      create: (context) => ClassesBloc(
        getIt.get<SettingsRepository>(),
        getIt.get<ClassesRepository>(),
      )..add(LoadClasses()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.clazz),
          elevation: 0,
        ),
        body: BlocBuilder<ClassesBloc, ClassesState>(builder: (context, state) {
          if (!(state is Classes)) {
            return SizedBox();
          }

          return Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: state.classes
                          ?.map((e) => ClassCard(classItem: e))
                          .toList() ??
                      [],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextButton(
                    onPressed: state.selectedClass == null
                        ? null
                        : () {
                            _navigateNext(context);
                            _submitClass(context, state);
                          },
                    child: Text(AppLocalizations.of(context)!.select)),
              ),
            ],
          );
        }),
      ),
    );
  }

  _navigateNext(BuildContext context) {
    final selectedRace =
        BlocProvider.of<CharacterCreatorBloc>(context).state.race;
    if (selectedRace != null && selectedRace.abilityBonusOptions != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CharacteristicsBonus(race: selectedRace)));
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SetCharacteristicsScreen()));
    }
  }

  _submitClass(BuildContext context, Classes classes) {
    final selectedClass = classes.selectedClass;
    if (selectedClass == null) {
      return;
    }

    BlocProvider.of<CharacterCreatorBloc>(context)
        .add(SubmitClass(selectedClass));
  }
}

class ClassCard extends StatelessWidget {
  final Class classItem;

  const ClassCard({Key? key, required this.classItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassesBloc, ClassesState>(builder: (context, state) {
      if (!(state is Classes)) {
        return SizedBox();
      }

      final currentClassSelected =
          state.selectedClass?.index == classItem.index;
      return Card(
        color: currentClassSelected
            ? Color(0xFF5B5E60)
            : Theme.of(context).primaryColorLight,
        child: InkWell(
          onTap: () {
            BlocProvider.of<ClassesBloc>(context).add(SelectClass(classItem));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Image.asset(
                  classItem.imageAsset,
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                classItem.name,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      );
    });
  }
}
