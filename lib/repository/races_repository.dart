import 'dart:convert';

import 'package:dnd_player_flutter/dto/race.dart';

class RacesRepository {
  final Future<String> Function(String lang) jsonReader;

  List<Race>? races;
  String? language;

  RacesRepository(this.jsonReader);

  Future<List<Race>> getRaces(String language) async {
    if (races != null && this.language == language) {
      return races!;
    }

    this.language = language;

    final response = await jsonReader(language);
    final List<dynamic> racesJson = json.decode(response);
    races = racesJson.map((raceJson) => _fromJson(raceJson)).toList();
    return races!;
  }

  Future<Race> findByIndex(String language, String index) async {
    final races = await getRaces(language);
    return races.firstWhere((element) => element.index == index);
  }

  Race _fromJson(Map<String, dynamic> json) {
    final abilityBonusOptionsJson = json["ability_bonus_options"];

    return Race(
        json["index"] as String,
        json["name"] as String,
        json["description"],
        json["speed"],
        json["ability_bonus_description"],
        _abilityBonusesFromJson(json["ability_bonuses"]),
        abilityBonusOptionsJson != null
            ? _abilityBonusOptionsFromJson(abilityBonusOptionsJson)
            : null,
        json["age"] as String,
        json["alignment"] as String,
        _parseSize(json["size"] as String),
        json["size_description"] as String,
        json["language_desc"] as String);
  }

  List<AbilityBonus> _abilityBonusesFromJson(List<dynamic> json) {
    return json.map((e) => _mapAbilityBonus(e)).toList();
  }

  AbilityBonusOptions _abilityBonusOptionsFromJson(Map<String, dynamic> json) {
    return AbilityBonusOptions(
        json["choose"],
        (json["from"] as List<dynamic>)
            .map((e) => _mapAbilityBonus(e))
            .toList());
  }

  AbilityBonus _mapAbilityBonus(dynamic json) {
    final abilityScore = json["ability_score"] as Map<String, dynamic>;
    final bonus = json["bonus"];

    return AbilityBonus(
      AbilityScore(
          abilityScore["index"] as String, abilityScore["name"] as String),
      bonus,
    );
  }

  Size _parseSize(String json) {
    switch (json.toLowerCase()) {
      case "medium":
        return Size.MEDIUM;
      case "small":
        return Size.SMALL;
      case "large":
        return Size.LARGE;
      default:
        return Size.MEDIUM;
    }
  }
}
