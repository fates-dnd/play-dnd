import 'dart:convert';

import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/repository/mappers.dart';

class ClassesRepository {
  final Future<String> Function() jsonReader;

  List<Class>? classes;

  ClassesRepository(this.jsonReader);

  Future<List<Class>> getClasses() async {
    if (classes != null) {
      return classes!;
    }

    final response = await jsonReader();
    final List<dynamic> classesJson = json.decode(response);
    classes = classesJson.map((classJson) => _fromJson(classJson)).toList();
    return classes!;
  }

  Future<Class> findByIndex(String index) async {
    final classes = await getClasses();
    return classes.firstWhere((element) => element.index == index);
  }

  Class _fromJson(Map<String, dynamic> json) {
    return Class(
        json["index"],
        json["name"],
        _readSavingThrows(json["saving_throws"] as List<dynamic>),
        _readSpellcastingAbility(json["spellcasting"]));
  }

  List<Characteristic> _readSavingThrows(List<dynamic> json) {
    return json.map((e) {
      final index = e["index"];
      return indexAsCharacteristic(index);
    }).toList();
  }

  Characteristic? _readSpellcastingAbility(dynamic json) {
    if (json == null) {
      return null;
    }
    final index = json["spellcasting_ability"]["index"];
    return indexAsCharacteristic(index);
  }
}
