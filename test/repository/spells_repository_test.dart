import 'dart:io';

import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:test/test.dart';

void main() {
  SpellsRepository spellsRepository;

  test('load spells', () async {
    spellsRepository = SpellsRepository((language) {
      final file = File("assets/rules/ru/spells.json");
      return file.readAsString();
    });

    final spells = await spellsRepository.getSpells("ru");

    expect(spells[0].index, "acid-splash");
    expect(spells[0].range, "60 футов");
    expect(spells[0].components[0], Component.VERBAL);
    expect(spells[0].components[1], Component.SOMATIC);
  });
}
