import 'dart:io';

import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:test/test.dart';

void main() {

  test('load equipment', () async {
    final equipmentFile = File("assets/equipment.json");
    final contents = await equipmentFile.readAsString();

    final repository = EquipmentRepository(() async {
      return contents;
    });

    final equipmentList = await repository.getEquipment();
    expect(equipmentList.length, 131);
  });
}