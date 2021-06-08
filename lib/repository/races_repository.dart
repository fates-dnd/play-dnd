import 'dart:convert';

import 'package:dnd_player_flutter/dto/race.dart';

class RacesRepository {

  final Future<String> Function() jsonReader;

  RacesRepository(this.jsonReader);
  
  Future<List<Race>> getRaces() async {
    final response = await jsonReader();
    final List<dynamic> racesJson = json.decode(response);
    return racesJson.map((raceJson) => _fromJson(raceJson)).toList();
  }

  Race _fromJson(Map<String, dynamic> json) {
    return Race(
      json["index"] as String,
      json["name"] as String,
      json["description"] as String,
      json["speed"],
      json["ability_bonus_description"],
      _abilityBonusesFromJson(json["ability_bonuses"]),
      json["age"] as String,
    );
  }

  List<AbilityBonus> _abilityBonusesFromJson(List<dynamic> json) {
    return json.map((e) {
      final abilityScore = e["ability_score"] as Map<String, dynamic>;
      final bonus = e["bonus"];

      return AbilityBonus(
        AbilityScore(
          abilityScore["index"] as String,
          abilityScore["name"] as String
        ),
        bonus,
      );
    }).toList();
  }
}
