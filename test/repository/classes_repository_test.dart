import 'dart:io';

import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:test/test.dart';

void main() {
  late ClassesRepository classesRepository;

  test('load classes en', () async {
    final classesFile = File("assets/rules/en/classes.json");
    final classesContents = await classesFile.readAsString();

    final SkillsRepository skillsRepository =
        SkillsRepository((language) async {
      return await File("assets/rules/en/skills.json").readAsString();
    });

    final EquipmentRepository equipmentRepository =
        EquipmentRepository((language) async {
      return await File("assets/rules/en/equipment.json").readAsString();
    });

    classesRepository = ClassesRepository(skillsRepository, equipmentRepository,
        (language) async {
      return classesContents;
    });

    final classes = await classesRepository.getClasses("en");

    expect(classes.length, 12);
    expect(classes[1].index, "bard");
    expect(classes[1].name, "Bard");
    expect(classes[1].savingThrows.length, 2);
    expect(classes[1].spellcastingAbility, Characteristic.CHARISMA);
    expect(classes[1].savingThrows[0], Characteristic.DEXTERITY);
    expect(classes[1].savingThrows[1], Characteristic.CHARISMA);
    expect(classes[1].startingEquipment![0].equipment.index, "leather");
    expect(classes[1].startingEquipment![0].quantity, 1);
    expect(classes[1].startingEquipment![1].equipment.index, "dagger");
    expect(
        classes[1].equipmentChoices![0].options[0].equipment.index, "rapier");
    expect(classes[1].equipmentChoices![0].options[0].quantity, 1);
    expect(classes[1].equipmentProficiencies[0]["armor_category"], "Light");
  });

  test('load classes ru', () async {
    final classesFile = File("assets/rules/ru/classes.json");
    final classesContents = await classesFile.readAsString();

    final SkillsRepository skillsRepository =
        SkillsRepository((language) async {
      return await File("assets/rules/ru/skills.json").readAsString();
    });

    final EquipmentRepository equipmentRepository =
        EquipmentRepository((language) async {
      return await File("assets/rules/ru/equipment.json").readAsString();
    });

    classesRepository = ClassesRepository(skillsRepository, equipmentRepository,
        (language) async {
      return classesContents;
    });

    final classes = await classesRepository.getClasses("ru");

    expect(classes.length, 12);
    expect(classes[1].index, "bard");
    expect(classes[1].name, "Бард");
    expect(classes[1].savingThrows.length, 2);
    expect(classes[1].spellcastingAbility, Characteristic.CHARISMA);
    expect(classes[1].savingThrows[0], Characteristic.DEXTERITY);
    expect(classes[1].savingThrows[1], Characteristic.CHARISMA);
    expect(classes[1].startingEquipment![0].equipment.index, "leather");
    expect(classes[1].startingEquipment![0].quantity, 1);
    expect(classes[1].startingEquipment![1].equipment.index, "dagger");
    expect(classes[1].startingEquipment![1].quantity, 1);
    expect(
        classes[1].equipmentChoices![0].options[0].equipment.index, "rapier");
    expect(classes[1].equipmentChoices![0].options[0].quantity, 1);
    expect(classes[1].equipmentProficiencies[0]["armor_category"], "Light");
  });
}
