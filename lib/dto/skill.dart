import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:equatable/equatable.dart';

class Skill extends Equatable {
  final String index;
  final String name;
  final Characteristic characteristic;

  Skill(this.index, this.name, this.characteristic);

  @override
  List<Object?> get props => [index, name, characteristic];
}
