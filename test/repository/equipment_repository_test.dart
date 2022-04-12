import 'dart:io';

import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:test/test.dart';

void main() {
  test('load equipment en', () async {
    final equipmentFile = File("assets/rules/en/equipment.json");
    final contents = await equipmentFile.readAsString();

    final repository = EquipmentRepository((language) async {
      return contents;
    });

    final equipmentList = await repository.getEquipment("en");
    expect(equipmentList.length, 238);
  });
}
