import 'dart:convert';

import 'package:dnd_player_flutter/dto/trait.dart';

class TraitsRepository {

  final Future<String> Function() jsonReader;

  TraitsRepository(this.jsonReader);

  Future<List<Trait>> getTraits() async {
    final response = await jsonReader();
    final List<dynamic> traitsJson = json.decode(response);
    return traitsJson.map((traitJson) => _fromJson(traitJson)).toList();
  }

  Trait _fromJson(Map<String, dynamic> json) {
    return Trait(
      json["index"] as String,
      _traitRacesFromJson(json["races"]),
      json["name"],
      (json["desc"] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  List<TraitRace> _traitRacesFromJson(List<dynamic> json) {
    return json.map((e) => TraitRace(
      e["index"] as String,
      e["name"] as String,
    )).toList();
  }
}
