import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String name;
  final int level;
  final int maxHp;
  final int hp;
  final int baseStrength;
  final int baseDexterity;
  final int baseConstitution;
  final int baseIntelligence;
  final int baseWisdom;
  final int baseCharisma;

  final Race race;
  final Class clazz;

  final List<Skill> selectedProficiencies;
  final List<EquipmentQuantity> selectedEquipment;

  Character(
    this.name,
    this.level,
    this.maxHp,
    this.hp,
    this.baseStrength,
    this.baseDexterity,
    this.baseConstitution,
    this.baseIntelligence,
    this.baseWisdom,
    this.baseCharisma,
    this.race,
    this.clazz,
    this.selectedProficiencies,
    this.selectedEquipment,
  );

  @override
  List<Object?> get props => [
        name,
        level,
        maxHp,
        hp,
        baseStrength,
        baseDexterity,
        baseConstitution,
        baseIntelligence,
        baseWisdom,
        baseCharisma,
        race,
        clazz,
        selectedProficiencies,
        selectedEquipment,
      ];
}
