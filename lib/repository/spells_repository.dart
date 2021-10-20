import 'package:dnd_player_flutter/dto/spell.dart';

class SpellsRepository {
  final Future<String> Function() jsonReader;

  SpellsRepository(this.jsonReader);

  Future<List<Spell>> getSpells() async {
    return <Spell>[];
  }
}
