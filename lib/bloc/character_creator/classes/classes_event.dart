part of 'classes_bloc.dart';

@immutable
abstract class ClassesEvent {}

class LoadClasses extends ClassesEvent { }

class SelectClass extends ClassesEvent {

  final Class clazz;

  SelectClass(this.clazz);
}
