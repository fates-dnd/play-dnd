import 'package:dnd_player_flutter/bloc/classes/classes_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClassesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClassesBloc>(
      create: (context) =>
          ClassesBloc(getIt.get<ClassesRepository>())..add(LoadClasses()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<ClassesBloc, ClassesState>(builder: (context, state) {
          if (!(state is ClassessLoaded)) {
            return SizedBox();
          }

          return GridView.count(
            crossAxisCount: 2,
            children:
                state.classes.map((e) => ClassCard(classItem: e)).toList(),
          );
        }),
      ),
    );
  }
}

class ClassCard extends StatelessWidget {
  final Class classItem;

  const ClassCard({Key? key, required this.classItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorLight,
      child: Column(
        children: [
          Image.asset(classItem.imageAsset),
          Text(classItem.name),
        ],
      ),
    );
  }
}
