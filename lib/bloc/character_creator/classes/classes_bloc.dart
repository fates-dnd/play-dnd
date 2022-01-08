import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:meta/meta.dart';

part 'classes_event.dart';

part 'classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  final SettingsRepository settingsRepository;
  final ClassesRepository classesRepository;

  Class? clazz;
  List<Class>? classes;

  ClassesBloc(
    this.settingsRepository,
    this.classesRepository,
  ) : super(ClassesInitial()) {
    on<ClassesEvent>((event, emit) async {
      emit(await processEvent(event));
    });
  }

  Future<ClassesState> processEvent(
    ClassesEvent event,
  ) async {
    if (event is LoadClasses) {
      final language = await settingsRepository.getLanguage();
      classes = await classesRepository.getClasses(language);
      return Classes(clazz, classes);
    } else if (event is SelectClass) {
      clazz = event.clazz;
      return Classes(clazz, classes);
    }

    return state;
  }
}
