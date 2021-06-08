import 'package:flutter/services.dart';

Future<String> readRacesJson() async {
  return rootBundle.loadString("assets/races.json");
}