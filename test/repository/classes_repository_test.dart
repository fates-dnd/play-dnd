import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:test/test.dart';

import 'test_repository_factory.dart';

void main() {
  test('load classes en', () async {
    final classesRepository = await createClassesRepository();
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
}
