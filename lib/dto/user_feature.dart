import 'package:dnd_player_flutter/dto/rest.dart';
import 'package:hive/hive.dart';

part 'user_feature.g.dart';

@HiveType(typeId: 3)
class UserFeature {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  Usage? usage;

  UserFeature({
    required this.name,
    required this.description,
    this.usage,
  });
}

@HiveType(typeId: 4)
class Usage {
  @HiveField(0)
  int maxUsages;

  @HiveField(1)
  int usages;

  @HiveField(2)
  Rest? resetsOn;

  Usage(this.maxUsages, this.usages, this.resetsOn);
}
