import 'package:dnd_player_flutter/dto/character.dart';

class CharacterOutline {
  final String name;
  final int level;
  final int baseStrength;
  final int baseDexterity;
  final int baseConstitution;
  final int baseIntelligence;
  final int baseWisdom;
  final int baseCharisma;

  final String raceIndex;
  final String classIndex;
  final List<String> equipmentIndexes;
  final List<String> equippedItems;

  final List<String> preparedSpells;
  final List<String> learnedSpells;

  CharacterOutline(
    this.name,
    this.level,
    this.baseStrength,
    this.baseDexterity,
    this.baseConstitution,
    this.baseIntelligence,
    this.baseWisdom,
    this.baseCharisma,
    this.raceIndex,
    this.classIndex,
    this.equipmentIndexes,
    this.equippedItems,
    this.preparedSpells,
    this.learnedSpells,
  );

  static CharacterOutline fromCharacter(
    Character character, {
    required List<String> equipment,
    required List<String> equippedItems,
    required List<String> preparedSpells,
    required List<String> learnedSpells,
  }) {
    return CharacterOutline(
      character.name,
      character.level,
      character.baseStrength,
      character.baseDexterity,
      character.baseConstitution,
      character.baseIntelligence,
      character.baseWisdom,
      character.baseCharisma,
      character.race.index,
      character.clazz.index,
      equipment,
      equippedItems,
      preparedSpells,
      learnedSpells,
    );
  }

  CharacterOutline copyWith({
    String? name,
    int? level,
    int? baseStrength,
    int? baseDexterity,
    int? baseConstitution,
    int? baseIntelligence,
    int? baseWisdom,
    int? baseCharisma,
    String? raceIndex,
    String? classIndex,
    List<String>? equipmentIndexes,
    List<String>? equippedItems,
    List<String>? preparedSpells,
    List<String>? learnedSpells,
  }) {
    return CharacterOutline(
      name ?? this.name,
      level ?? this.level,
      baseStrength ?? this.baseStrength,
      baseDexterity ?? this.baseDexterity,
      baseConstitution ?? this.baseConstitution,
      baseIntelligence ?? this.baseIntelligence,
      baseWisdom ?? this.baseWisdom,
      baseCharisma ?? this.baseCharisma,
      raceIndex ?? this.raceIndex,
      classIndex ?? this.classIndex,
      equipmentIndexes ?? this.equipmentIndexes,
      equippedItems ?? this.equippedItems,
      preparedSpells ?? this.preparedSpells,
      learnedSpells ?? this.learnedSpells,
    );
  }
}
