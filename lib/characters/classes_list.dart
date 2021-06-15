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
        appBar: AppBar(
          title: Text("Клас"),
          elevation: 0,
        ),
        body: BlocBuilder<ClassesBloc, ClassesState>(builder: (context, state) {
          if (!(state is ClassessLoaded)) {
            return SizedBox();
          }

          return Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: state.classes
                      .map((e) => ClassCard(classItem: e))
                      .toList(),
                ),
              ),
              TextButton(
                  onPressed: () {
                  },
                  child: Text("Выбрать")),
            ],
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            classItem.imageAsset,
            width: 116,
            height: 116,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            classItem.name,
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
