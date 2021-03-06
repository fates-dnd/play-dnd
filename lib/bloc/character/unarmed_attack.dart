import 'package:dnd_player_flutter/dto/equipment.dart';

class UnarmedAttack {
  final int attackBonus;
  final int? damage;
  final DamageDice? damageDice;

  UnarmedAttack({
    required this.attackBonus, 
    this.damage, 
    this.damageDice
  });
}