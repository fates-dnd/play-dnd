import 'dart:convert';

import 'package:dnd_player_flutter/dto/race.dart';
import 'package:flutter/services.dart';

class RacesRepository {
  
  Future<List<Race>> readRaces() async {
    final response = await rootBundle.loadString("assets/races.json");
    final List<dynamic> racesJson = json.decode(response);
    return racesJson.map((raceJson) => _fromJson(raceJson)).toList();
  }

  Race _fromJson(Map<String, dynamic> json) {
    return Race(
      json["index"] as String,
      json["name"] as String,
      json["description"] as String,
      json["speed"],
    );
  }
}
