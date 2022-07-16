import 'package:hive/hive.dart';

part 'rest.g.dart';

@HiveType(typeId: 5)
enum Rest {
  @HiveField(0)
  SHORT,

  @HiveField(1)
  LONG,
}
