import 'package:dnd_player_flutter/dto/class.dart';

class ClassesRepository {
  
  final Future<String> Function() jsonReader;

  ClassesRepository(this.jsonReader);

  Future<List<Class>> getClasses() async {
    return [];
  }
}