import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:equatable/equatable.dart';

import 'equipment.dart';

class Class extends Equatable {
  final String index;
  final String name;
  final int? hitDie;
  final List<Characteristic> savingThrows;
  final Characteristic? spellcastingAbility;
  final ProficiencyChoices proficiencyChoices;
  final List<EquipmentQuantity>? startingEquipment;
  final List<EquipmentChoices>? equipmentChoices;
  final List<Map<String, String>> equipmentProficiencies;

  String get imageAsset => _indexToImageAsset();

  Class(
    this.index,
    this.name,
    this.hitDie,
    this.savingThrows,
    this.spellcastingAbility,
    this.proficiencyChoices,
    this.startingEquipment,
    this.equipmentChoices,
    this.equipmentProficiencies,
  );

  @override
  List<Object?> get props => [index, name];
}

class ProficiencyChoices {
  final int choose;
  final List<Skill> options;

  ProficiencyChoices(this.choose, this.options);
}

class EquipmentChoices {
  final int choose;
  final List<EquipmentQuantity> options;

  EquipmentChoices(this.choose, this.options);
}

class EquipmentQuantity extends Equatable {
  final Equipment equipment;
  final int quantity;

  EquipmentQuantity(this.equipment, this.quantity);

  bool get isStackable => equipment.isStackable;

  @override
  List<Object?> get props => [equipment, quantity];
}

extension OnClass on Class {
  String _indexToImageAsset() {
    switch (index) {
      case "barbarian":
        return "assets/drawable/icons/barbarian.png";
      case "bard":
        return "assets/drawable/icons/bard.png";
      case "cleric":
        return "assets/drawable/icons/cleric.png";
      case "druid":
        return "assets/drawable/icons/druid.png";
      case "fighter":
        return "assets/drawable/icons/fighter.png";
      case "monk":
        return "assets/drawable/icons/monk.png";
      case "paladin":
        return "assets/drawable/icons/paladin.png";
      case "ranger":
        return "assets/drawable/icons/ranger.png";
      case "rogue":
        return "assets/drawable/icons/rogue.png";
      case "sorcerer":
        return "assets/drawable/icons/sorcerer.png";
      case "warlock":
        return "assets/drawable/icons/warlock.png";
      case "wizard":
        return "assets/drawable/icons/wizard.png";
      default:
        return "";
    }
  }
}
