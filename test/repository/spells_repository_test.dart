import 'dart:io';

import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:test/test.dart';

void main() {
  SpellsRepository spellsRepository;

  test('load spells ru', () async {
    spellsRepository = SpellsRepository((language) {
      final file = File("assets/rules/ru/spells.json");
      return file.readAsString();
    });

    final spells = await spellsRepository.getSpells("ru");

    expect(spells.length, 319);
    expect(spells[0].index, "acid-arrow");
    expect(spells[0].range, "90 feet");
    expect(spells[0].components[0], Component.VERBAL);
    expect(spells[0].components[1], Component.SOMATIC);
    expect(spells[0].components[2], Component.MATERIAL);
  });

  test('load spells en', () async {
    spellsRepository = SpellsRepository((language) {
      final file = File("assets/rules/en/spells.json");
      return file.readAsString();
    });

    final spells = await spellsRepository.getSpells("en");

    expect(spells.length, 319);
  });
}
