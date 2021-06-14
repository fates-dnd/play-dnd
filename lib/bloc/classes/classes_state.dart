part of 'classes_bloc.dart';

@immutable
abstract class ClassesState {}

class ClassesInitial extends ClassesState {}

class ClassessLoaded extends ClassesState {
  
  final List<Class> classes;

  ClassessLoaded(this.classes);
}
