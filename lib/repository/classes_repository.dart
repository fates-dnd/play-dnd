import 'dart:convert';

import 'package:dnd_player_flutter/dto/class.dart';

class ClassesRepository {
  
  final Future<String> Function() jsonReader;

  ClassesRepository(this.jsonReader);

  Future<List<Class>> getClasses() async {
    final response = await jsonReader();
    final List<dynamic> classesJson = json.decode(response);
    return classesJson.map((classJson) => _fromJson(classJson)).toList();
  }

  Class _fromJson(Map<String, dynamic> json) {
    return Class(
      json["index"], 
      json["name"]
    );
  }
}
