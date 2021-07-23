import 'dart:convert';

import 'package:dnd_player_flutter/data/characteristics.dart';
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
      json["name"],
      _readSavingThrows(json["saving_throws"] as List<dynamic>)
    );
  }

  List<Characteristic> _readSavingThrows(List<dynamic> json) {
    return json.map((e) {
      final index = e["index"];
      switch (index) {
        case "str": return Characteristic.STRENGTH;
        case "dex": return Characteristic.DEXTERITY;
        case "con": return Characteristic.CONSTITUTION;
        case "int": return Characteristic.INTELLECT;
        case "wis": return Characteristic.WISDOM;
        case "cha": return Characteristic.CHARISMA;
        default: throw ArgumentError("Index $index is not a characteristic.");
      }
    }).toList();
  }
}
