import 'dart:io';

import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:test/test.dart';

void main() {
  SpellsRepository spellsRepository;

  test('load spells en', () async {
    spellsRepository = SpellsRepository((language) {
      final file = File("assets/rules/en/spells.json");
      return file.readAsString();
    });

    final spells = await spellsRepository.getSpells("en");

    expect(spells.length, 319);
  });
}
