import 'dart:convert';

import 'package:dnd_player_flutter/dto/feature.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';

class FeaturesRepository {
  final Future<String> Function(String lang) jsonReader;
  final ClassesRepository classesRepository;

  List<Feature>? loadedFeatures;
  String? language;

  FeaturesRepository(
    this.jsonReader,
    this.classesRepository,
  );

  Future<List<Feature>> getFeatures(String language) async {
    if (this.language == language && loadedFeatures != null) {
      return loadedFeatures!;
    }

    final response = await jsonReader(language);
    final List<dynamic> featuresJson = json.decode(response);
    return Future.wait(
        featuresJson.map((e) => _fromJson(language, e)).toList());
  }

  Future<Feature> findByIndex(String language, String index) async {
    final features = await getFeatures(language);
    return features.firstWhere((element) => element.index == index);
  }

  Future<Feature> _fromJson(String language, Map<String, dynamic> json) async {
    return Feature(
      json["index"],
      await classesRepository.findByIndex(language, json["class"]["index"]),
      json["name"],
      json["level"],
      json["levels"]?.cast<String, int>(),
      json["level_names"]?.cast<String, String>(),
      json["expandable"],
      (json["desc"] as List<dynamic>).cast(),
      json["parent"]?["index"],
    );
  }
}
