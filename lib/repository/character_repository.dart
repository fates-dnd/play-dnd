import 'package:dnd_player_flutter/dto/character.dart';
import 'package:hive/hive.dart';

class CharacterRepository {

  late Box box;

  CharacterRepository() {
    box = Hive.box('characters');
  }

  void insertCharacter(Character character) {
    var currentList = box.get('character_list') as List<Character>?;
    if (currentList == null) {
      currentList = <Character>[];
    }
    currentList.add(character);
    box.put('character_list', currentList);
  }

  List<Character> getCharacters() {
    final characters = box.get('character_list') as List?;
    return characters?.map((e) => e as Character).toList() ?? [];
  }
}
