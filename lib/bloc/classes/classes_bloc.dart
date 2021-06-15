import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:meta/meta.dart';

part 'classes_event.dart';
part 'classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {

  final ClassesRepository classesRepository;

  Class? clazz;
  List<Class>? classes;

  ClassesBloc(this.classesRepository) : super(ClassesInitial());

  @override
  Stream<ClassesState> mapEventToState(
    ClassesEvent event,
  ) async* {
    if (event is LoadClasses) {
      classes = await classesRepository.getClasses();
      yield Classes(clazz, classes);
    } else if (event is SelectClass) {
      clazz = event.clazz;
      yield Classes(clazz, classes);
    }
  }
}
