import 'dart:io';

import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:test/test.dart';

void main() {
  test('load equipment', () async {
    final equipmentFile = File("assets/rules/ru/equipment.json");
    final contents = await equipmentFile.readAsString();

    final repository = EquipmentRepository((language) async {
      return contents;
    });

    final equipmentList = await repository.getEquipment("ru");
    expect(equipmentList.length, 131);
  });
}
