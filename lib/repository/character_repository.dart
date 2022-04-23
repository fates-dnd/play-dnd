import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/currency.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/dto/feature.dart';
import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/races_repository.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:dnd_player_flutter/storage/character_outline.dart';
import 'package:hive/hive.dart';

const CURRENT_VERSION = 1;

class CharacterRepository {
  final SettingsRepository settingsRepository;
  final RacesRepository racesRepository;
  final ClassesRepository classesRepository;
  final SkillsRepository skillsRepository;
  final EquipmentRepository equipmentRepository;

  late Box box;

  CharacterRepository(
    this.settingsRepository,
    this.racesRepository,
    this.classesRepository,
    this.skillsRepository,
    this.equipmentRepository,
  ) {
    box = Hive.box("characters");

    final version = box.get("version", defaultValue: 0);
    if (CURRENT_VERSION > version) {
      box.clear();
      box.put("version", CURRENT_VERSION);
    }
  }

  void insertCharacter(Character character) {
    var currentList = _readCharacterOutlines();
    if (currentList == null) {
      currentList = <CharacterOutline>[];
    }
    currentList.add(CharacterOutline.fromCharacter(
      character,
      equipment: character.selectedEquipment
          .map((e) => EquipmentIndexQuantity(
              e.equipment.index, e.quantity, e.isEquipped))
          .toList(),
      equippedItems: [],
      preparedSpells: [],
      learnedSpells: [],
      usedSpellSlots: {},
      money: {
        Currency.COPPER.index: 0,
        Currency.SILVER.index: 0,
        Currency.ELECTRUM.index: 0,
        Currency.GOLD.index: 0,
        Currency.PLATINUM.index: 0,
      },
      featureUsage: {},
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
    final currentEquipmentList = currentList[targetIndex].allEquipment;
    final foundEquipmentIndex = currentEquipmentList.indexWhere(
      (element) => element.index == equipment.index,
    );

    if (foundEquipmentIndex != -1 && equipment.isStackable) {
      final foundEquipment = currentEquipmentList[foundEquipmentIndex];
      currentEquipmentList[foundEquipmentIndex] = EquipmentIndexQuantity(
        equipment.index,
        foundEquipment.quantity + 1,
        foundEquipment.isEquipped,
      );
    } else {
      currentEquipmentList
          .add(EquipmentIndexQuantity(equipment.index, 1, false));
    }

    currentList[targetIndex] = currentList[targetIndex]
        .copyWith(allEquipmentIndexes: currentEquipmentList);

    box.put('character_list', currentList);
  }

  void removeEquipmentFromCharacter(
      Character character, EquipmentQuantity equipment) {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return;
    }

    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    final currentEquipmentList = currentList[targetIndex].allEquipment;

    final equipmentIndex = currentEquipmentList
        .indexWhere((element) => element.index == equipment.equipment.index);

    final equipmentItem = currentEquipmentList[equipmentIndex];

    if (equipmentItem.quantity > 1) {
      currentEquipmentList[equipmentIndex] = EquipmentIndexQuantity(
          equipmentItem.index,
          equipmentItem.quantity - 1,
          equipmentItem.isEquipped);
    } else {
      currentEquipmentList.removeAt(equipmentIndex);
    }

    currentList[targetIndex] = currentList[targetIndex].copyWith(
      allEquipmentIndexes: currentEquipmentList,
    );

    box.put('character_list', currentList);
  }

  void equipItem(Character character, EquipmentQuantity equipment) {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return;
    }

    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    final allEquipment = currentList[targetIndex].allEquipment;

    final itemIndex = allEquipment.indexWhere((element) =>
        element.index == equipment.equipment.index &&
        element.quantity == equipment.quantity &&
        element.isEquipped == equipment.isEquipped);

    allEquipment[itemIndex] = EquipmentIndexQuantity(
      equipment.equipment.index,
      equipment.quantity,
      true,
    );

    currentList[targetIndex] = currentList[targetIndex].copyWith(
      allEquipmentIndexes: allEquipment,
    );

    box.put('character_list', currentList);
  }

  void unequipItem(Character character, EquipmentQuantity equipment) {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return;
    }

    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    final allEquipment = currentList[targetIndex].allEquipment;

    final itemIndex = allEquipment.indexWhere((element) =>
        element.index == equipment.equipment.index &&
        element.quantity == equipment.quantity &&
        element.isEquipped == equipment.isEquipped);

    allEquipment[itemIndex] = EquipmentIndexQuantity(
      equipment.equipment.index,
      equipment.quantity,
      false,
    );

    currentList[targetIndex] = currentList[targetIndex].copyWith(
      allEquipmentIndexes: allEquipment,
    );

    box.put('character_list', currentList);
  }

  List<String> getProficientSkillIndexes(Character character) {
    final currentList = _readCharacterOutlines();
    final storedCharacter =
        currentList?.firstWhere((element) => element.name == character.name);
    return storedCharacter?.proficiencyIndexes ?? [];
  }

  List<EquipmentIndexQuantity> getCharacterEquipmentIndexQuantities(
      Character character) {
    final currentList = _readCharacterOutlines();
    final storedCharacter =
        currentList?.firstWhere((element) => element.name == character.name);
    return storedCharacter?.allEquipment ?? [];
  }

  void updatePreparedSpells(Character character, List<Spell> spells) {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return;
    }
    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    currentList[targetIndex] = currentList[targetIndex]
        .copyWith(preparedSpells: spells.map((e) => e.index).toList());

    box.put('character_list', currentList);
  }

  List<String> getPreparedSpellsIndexes(Character character) {
    final currentList = _readCharacterOutlines();
    final currentCharacterOutline =
        currentList?.firstWhere((element) => element.name == character.name);

    return currentCharacterOutline?.preparedSpells ?? [];
  }

  void updateLearnedSpells(Character character, List<Spell> spells) {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return;
    }
    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    currentList[targetIndex] = currentList[targetIndex]
        .copyWith(learnedSpells: spells.map((e) => e.index).toList());

    box.put('character_list', currentList);
  }

  List<String> getLearnedSpellsIndexes(Character character) {
    final currentList = _readCharacterOutlines();
    final currentCharacterOutline =
        currentList?.firstWhere((element) => element.name == character.name);

    return currentCharacterOutline?.learnedSpells ?? [];
  }

  void useSpellSlot(Character character, int level) {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return;
    }

    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    final usedSpellSlots = currentList[targetIndex].usedSpellSlots;
    usedSpellSlots[level] = (usedSpellSlots[level] ?? 0) + 1;

    currentList[targetIndex] = currentList[targetIndex].copyWith(
      usedSpellSlots: usedSpellSlots,
    );

    box.put('character_list', currentList);
  }

  void unuseSpellSlot(Character character, int level) {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return;
    }

    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    final usedSpellSlots = currentList[targetIndex].usedSpellSlots;

    if (!usedSpellSlots.containsKey(level)) {
      return;
    }

    usedSpellSlots[level] = (usedSpellSlots[level] ?? 1) - 1;

    currentList[targetIndex] = currentList[targetIndex].copyWith(
      usedSpellSlots: usedSpellSlots,
    );

    box.put('character_list', currentList);
  }

  Future<Map<int, int>> getUsedSpellSlots(Character character) async {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return {};
    }

    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    return currentList[targetIndex].usedSpellSlots;
  }

  void setHp(Character character, int newHp) {
    final currentList = _readCharacterOutlines();

    final targetIndex =
        currentList?.indexWhere((element) => element.name == character.name);
    if (targetIndex != null) {
      currentList![targetIndex] = currentList[targetIndex].copyWith(
        hp: newHp,
      );
    }
    box.put('character_list', currentList);
  }

  Future<Map<int, int>> getMoney(Character character) async {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return {};
    }

    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    return currentList[targetIndex].money;
  }

  void earnMoney(Character character, int currency, int amount) {
    final currentList = _readCharacterOutlines();

    final targetIndex =
        currentList?.indexWhere((element) => element.name == character.name);
    if (targetIndex != null) {
      final currentMoney = currentList![targetIndex].money;
      currentMoney[currency] = (currentMoney[currency] ?? 0) + amount;
      currentList[targetIndex] =
          currentList[targetIndex].copyWith(money: currentMoney);
    }
    box.put('character_list', currentList);
  }

  void spendMoney(Character character, int currency, int amount) {
    final currentList = _readCharacterOutlines();

    final targetIndex =
        currentList?.indexWhere((element) => element.name == character.name);
    if (targetIndex != null) {
      final currentMoney = currentList![targetIndex].money;
      currentMoney[currency] = (currentMoney[currency] ?? 0) - amount;
      currentList[targetIndex] =
          currentList[targetIndex].copyWith(money: currentMoney);
    }
    box.put('character_list', currentList);
  }

  Future<Map<String, int>> getFeatureUsage(Character character) async {
    final currentList = _readCharacterOutlines();
    if (currentList == null) {
      return {};
    }

    final targetIndex =
        currentList.indexWhere((element) => element.name == character.name);
    return currentList[targetIndex].featureUsage;
  }

  void incrementFeature(Character character, Feature feature) async {
    final currentList = _readCharacterOutlines();
    final targetIndex =
        currentList?.indexWhere((element) => element.name == character.name);
    if (targetIndex != null) {
      final featureUsage = currentList![targetIndex].featureUsage;
      featureUsage[feature.index] = (featureUsage[feature.index] ?? 0) + 1;
      currentList[targetIndex] =
          currentList[targetIndex].copyWith(featureUsage: featureUsage);
    }
    box.put('character_list', currentList);
  }

  void decrementFeature(Character character, Feature feature) async {
    final currentList = _readCharacterOutlines();
    final targetIndex =
        currentList?.indexWhere((element) => element.name == character.name);
    if (targetIndex != null) {
      final featureUsage = currentList![targetIndex].featureUsage;
      featureUsage[feature.index] = (featureUsage[feature.index] ?? 0) - 1;
      currentList[targetIndex] =
          currentList[targetIndex].copyWith(featureUsage: featureUsage);
    }
    box.put('character_list', currentList);
  }

  Future<List<Character>> getCharacters() async {
    final outlines = _readCharacterOutlines() ?? [];

    return Future.wait(outlines.map((outline) async {
      final language = await settingsRepository.getLanguage();
      return Character(
        outline.name,
        outline.level,
        outline.maxHp,
        outline.hp,
        outline.baseStrength,
        outline.baseDexterity,
        outline.baseConstitution,
        outline.baseIntelligence,
        outline.baseWisdom,
        outline.baseCharisma,
        await racesRepository.findByIndex(language, outline.raceIndex),
        await classesRepository.findByIndex(language, outline.classIndex),
        await skillsRepository.findByIndexes(
            language, outline.proficiencyIndexes),
        await _mapAllEquipment(language, outline.allEquipment),
      );
    }).toList());
  }

  Future<List<EquipmentQuantity>> _mapAllEquipment(
      String language, List<EquipmentIndexQuantity> indexQuantities) async {
    final allEquipment = await equipmentRepository.findByIndexes(
        language, indexQuantities.map((it) => it.index).toList());

    return indexQuantities.map((e) {
      final equipment =
          allEquipment.firstWhere((element) => element.index == e.index);
      return EquipmentQuantity(equipment, e.quantity, e.isEquipped);
    }).toList();
  }

  List<CharacterOutline>? _readCharacterOutlines() {
    return (box.get('character_list') as List?)
        ?.where((e) => e != null)
        .map((e) => e as CharacterOutline)
        .toList();
  }
}
