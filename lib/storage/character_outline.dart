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
  final List<String> proficiencyIndexes;

  final List<String> equipmentIndexes;
  final List<String> equippedItems;

  final List<String> preparedSpells;
  final List<String> learnedSpells;

  final Map<int, int> usedSpellSlots;

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
    this.proficiencyIndexes,
    this.equipmentIndexes,
    this.equippedItems,
    this.preparedSpells,
    this.learnedSpells,
    this.usedSpellSlots,
  );

  static CharacterOutline fromCharacter(
    Character character, {
    required List<String> equipment,
    required List<String> equippedItems,
    required List<String> preparedSpells,
    required List<String> learnedSpells,
    required Map<int, int> usedSpellSlots,
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
      character.selectedProficiencies.map((skill) => skill.index).toList(),
      equipment,
      equippedItems,
      preparedSpells,
      learnedSpells,
      usedSpellSlots,
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
    List<String>? proficiencyIndexes,
    List<String>? equipmentIndexes,
    List<String>? equippedItems,
    List<String>? preparedSpells,
    List<String>? learnedSpells,
    Map<int, int>? usedSpellSlots,
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
      proficiencyIndexes ?? this.proficiencyIndexes,
      equipmentIndexes ?? this.equipmentIndexes,
      equippedItems ?? this.equippedItems,
      preparedSpells ?? this.preparedSpells,
      learnedSpells ?? this.learnedSpells,
      usedSpellSlots ?? this.usedSpellSlots,
    );
  }
}
