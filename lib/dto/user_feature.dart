import 'package:dnd_player_flutter/dto/rest.dart';

class UserFeature {
  final String name;
  final String description;
  final Usage? usage;

  UserFeature({
    required this.name,
    required this.description,
    this.usage,
  });
}

class Usage {
  final int usages;
  final Rest? resetsOn;

  Usage(this.usages, this.resetsOn);
}
