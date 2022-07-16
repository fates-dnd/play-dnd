import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/dto/user_feature.dart';
import 'package:hive/hive.dart';

part 'character_outline.g.dart';

@HiveType(typeId: 1)
class CharacterOutline {
  @HiveField(0)
  String name;

  @HiveField(1)
  int level;

  @HiveField(2)
  int maxHp;

  @HiveField(3)
  int hp;

  @HiveField(4)
  int baseStrength;

  @HiveField(5)
  int baseDexterity;

  @HiveField(6)
  int baseConstitution;

  @HiveField(7)
  int baseIntelligence;

  @HiveField(8)
  int baseWisdom;

  @HiveField(9)
  int baseCharisma;

  @HiveField(10)
  final String raceIndex;

  @HiveField(11)
  final String classIndex;

  @HiveField(12)
  final List<String> proficiencyIndexes;

  @HiveField(13)
  final List<EquipmentIndexQuantity> allEquipment;

  @HiveField(14)
  final List<String> preparedSpells;

  @HiveField(15)
  final List<String> learnedSpells;

  @HiveField(16)
  final Map<int, int> usedSpellSlots;

  @HiveField(17)
  final Map<int, int> money;

  @HiveField(18)
  final List<UserFeature> userFeatures;

  CharacterOutline(
    this.name,
    this.level,
    this.maxHp,
    this.hp,
    this.baseStrength,
    this.baseDexterity,
    this.baseConstitution,
    this.baseIntelligence,
    this.baseWisdom,
    this.baseCharisma,
    this.raceIndex,
    this.classIndex,
    this.proficiencyIndexes,
    this.allEquipment,
    this.preparedSpells,
    this.learnedSpells,
    this.usedSpellSlots,
    this.money,
    this.userFeatures,
  );

  static CharacterOutline fromCharacter(
    Character character, {
    required List<EquipmentIndexQuantity> equipment,
    required List<EquipmentIndexQuantity> equippedItems,
    required List<String> preparedSpells,
    required List<String> learnedSpells,
    required Map<int, int> usedSpellSlots,
    required Map<int, int> money,
    required Map<String, int> featureUsage,
    required List<UserFeature> userFeatures,
  }) {
    return CharacterOutline(
      character.name,
      character.level,
      character.maxHp,
      character.hp,
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
      preparedSpells,
      learnedSpells,
      usedSpellSlots,
      money,
      userFeatures,
    );
  }

  CharacterOutline copyWith({
    String? name,
    int? level,
    int? maxHp,
    int? hp,
    int? baseStrength,
    int? baseDexterity,
    int? baseConstitution,
    int? baseIntelligence,
    int? baseWisdom,
    int? baseCharisma,
    String? raceIndex,
    String? classIndex,
    List<String>? proficiencyIndexes,
    List<EquipmentIndexQuantity>? allEquipmentIndexes,
    List<String>? preparedSpells,
    List<String>? learnedSpells,
    Map<int, int>? usedSpellSlots,
    Map<int, int>? money,
    Map<String, int>? featureUsage,
    List<UserFeature>? userFeatures,
  }) {
    return CharacterOutline(
      name ?? this.name,
      level ?? this.level,
      maxHp ?? this.maxHp,
      hp ?? this.hp,
      baseStrength ?? this.baseStrength,
      baseDexterity ?? this.baseDexterity,
      baseConstitution ?? this.baseConstitution,
      baseIntelligence ?? this.baseIntelligence,
      baseWisdom ?? this.baseWisdom,
      baseCharisma ?? this.baseCharisma,
      raceIndex ?? this.raceIndex,
      classIndex ?? this.classIndex,
      proficiencyIndexes ?? this.proficiencyIndexes,
      allEquipmentIndexes ?? this.allEquipment,
      preparedSpells ?? this.preparedSpells,
      learnedSpells ?? this.learnedSpells,
      usedSpellSlots ?? this.usedSpellSlots,
      money ?? this.money,
      userFeatures ?? this.userFeatures,
    );
  }
}

@HiveType(typeId: 2)
class EquipmentIndexQuantity {
  @HiveField(0)
  String index;

  @HiveField(1)
  int quantity;

  @HiveField(2)
  bool isEquipped;

  EquipmentIndexQuantity(this.index, this.quantity, this.isEquipped);
}
