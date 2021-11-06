import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
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
    var currentList = _readCharacterOutlines();
    if (currentList == null) {
      currentList = <CharacterOutline>[];
    }
    currentList.add(CharacterOutline.fromCharacter(
      character,
      equipment: [],
      equippedItems: [],
      preparedSpells: [],
      learnedSpells: [],
    ));
    box.put('character_list', currentList);
  }

  void addEquipmentToCharacter(Character character, Equipment equipment) {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return;
    }
    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    final currentEquipmentList = currentList[targetIndex].equipmentIndexes;

    currentList[targetIndex] = currentList[targetIndex]
        .copyWith(equipmentIndexes: currentEquipmentList..add(equipment.index));

    box.put('character_list', currentList);
  }

  void removeEquipmentFromCharacter(Character character, Equipment equipment) {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return;
    }

    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    final currentEquipmentList = currentList[targetIndex].equipmentIndexes;
    final currentEquippedItems = currentList[targetIndex].equippedItems;

    currentList[targetIndex] = currentList[targetIndex].copyWith(
      equipmentIndexes: currentEquipmentList..remove(equipment.index),
      equippedItems: currentEquippedItems..remove(equipment.index),
    );

    box.put('character_list', currentList);
  }

  void equipItem(Character character, Equipment equipment) {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return;
    }

    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    final currentEquippedItems = currentList[targetIndex].equippedItems;
    currentList[targetIndex] = currentList[targetIndex].copyWith(
      equippedItems: currentEquippedItems..add(equipment.index),
    );

    box.put('character_list', currentList);
  }

  void unequipItem(Character character, Equipment equipment) {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return;
    }

    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    final currentEquippedItems = currentList[targetIndex].equippedItems;
    currentList[targetIndex] = currentList[targetIndex].copyWith(
      equippedItems: currentEquippedItems..remove(equipment.index),
    );

    box.put('character_list', currentList);
  }

  List<String> getCharacterEquipmentIndexes(Character character) {
    final currentList = _readCharacterOutlines();
    final storedCharacter =
        currentList?.firstWhere((element) => element.name == character.name);
    return storedCharacter?.equipmentIndexes ?? [];
  }

  List<String> getCharacterEquippedItemsIndexes(Character character) {
    final currentList = _readCharacterOutlines();
    final storedCharacter =
        currentList?.firstWhere((element) => element.name == character.name);
    return storedCharacter?.equippedItems ?? [];
  }

  Future<List<Character>> getCharacters() async {
    final outlines = _readCharacterOutlines() ?? [];

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

  List<CharacterOutline>? _readCharacterOutlines() {
    return (box.get('character_list') as List?)
        ?.map((e) => e as CharacterOutline)
        .toList();
  }
}
