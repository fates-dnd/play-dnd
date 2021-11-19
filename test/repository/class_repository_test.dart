import 'dart:io';

import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:test/expect.dart';
import 'package:test/test.dart';

void main() {
  late ClassesRepository classesRepository;

  test('load classes', () async {
    final classesFile = File("assets/rules/ru/classes.json");
    final contents = await classesFile.readAsString();

    classesRepository = _createRepository(contents);

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

ClassesRepository _createRepository(String contents) {
  return ClassesRepository((language) async {
    return contents;
  });
}
