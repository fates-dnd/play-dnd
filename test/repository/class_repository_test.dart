import 'dart:io';

import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:test/expect.dart';
import 'package:test/test.dart';

void main() {
  late ClassesRepository classesRepository;

  test('load classes', () async {
    final classesFile = File("assets/rules/ru/classes.json");
    final classesContents = await classesFile.readAsString();

    final SkillsRepository skillsRepository =
        SkillsRepository((language) async {
      return await File("assets/rules/ru/skills.json").readAsString();
    });

    classesRepository = ClassesRepository(skillsRepository, (language) async {
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
  });
}
