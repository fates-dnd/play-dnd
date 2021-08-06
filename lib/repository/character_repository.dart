import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:dnd_player_flutter/repository/races_repository.dart';
import 'package:dnd_player_flutter/storage/character_outline.dart';
import 'package:hive/hive.dart';

class CharacterRepository {
  final RacesRepository racesRepository;
  final ClassesRepository classesRepository;

  late Box box;

  CharacterRepository(
    this.racesRepository,
    this.classesRepository,
  ) {
    box = Hive.box('characters');
  }

  void insertCharacter(Character character) {
    var currentList = (box.get('character_list') as List?)
        ?.map((e) => e as CharacterOutline)
        .toList();
    if (currentList == null) {
      currentList = <CharacterOutline>[];
    }
    currentList.add(CharacterOutline.fromCharacter(character));
    box.put('character_list', currentList);
  }

  Future<List<Character>> getCharacters() async {
    final characters = box.get('character_list') as List?;
    final outlines =
        characters?.map((e) => e as CharacterOutline).toList() ?? [];

    return Future.wait(outlines.map((outline) async {
      return Character(
        outline.name,
        outline.level,
        outline.baseStrength,
        outline.baseDexterity,
        outline.baseConstitution,
        outline.baseIntelligence,
        outline.baseWisdom,
        outline.baseCharisma,
        await racesRepository.findByIndex(outline.raceIndex),
        await classesRepository.findByIndex(outline.classIndex),
      );
    }).toList());
  }
}
