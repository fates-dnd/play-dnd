import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:meta/meta.dart';

part 'classes_event.dart';
part 'classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {

  final ClassesRepository classesRepository;

  ClassesBloc(this.classesRepository) : super(ClassesInitial());

  @override
  Stream<ClassesState> mapEventToState(
    ClassesEvent event,
  ) async* {
    if (event is LoadClasses) {
      final classes = await classesRepository.getClasses();
      yield ClassessLoaded(classes);
    }
  }
}
