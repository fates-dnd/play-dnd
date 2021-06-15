part of 'classes_bloc.dart';

@immutable
abstract class ClassesState {}

class ClassesInitial extends ClassesState {}

class Classes extends ClassesState {
  
  final Class? selectedClass;
  final List<Class>? classes;

  Classes(this.selectedClass, this.classes);
}
