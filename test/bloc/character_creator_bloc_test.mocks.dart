// Mocks generated by Mockito 5.2.0 from annotations
// in dnd_player_flutter/test/bloc/character_creator_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i14;

import 'package:dnd_player_flutter/data/characteristics.dart' as _i16;
import 'package:dnd_player_flutter/dto/character.dart' as _i11;
import 'package:dnd_player_flutter/dto/class.dart' as _i8;
import 'package:dnd_player_flutter/dto/equipment.dart' as _i9;
import 'package:dnd_player_flutter/dto/race.dart' as _i17;
import 'package:dnd_player_flutter/dto/skill.dart' as _i19;
import 'package:dnd_player_flutter/dto/spell.dart' as _i13;
import 'package:dnd_player_flutter/dto/trait.dart' as _i18;
import 'package:dnd_player_flutter/dto/user_feature.dart' as _i15;
import 'package:dnd_player_flutter/repository/character_repository.dart'
    as _i10;
import 'package:dnd_player_flutter/repository/classes_repository.dart' as _i4;
import 'package:dnd_player_flutter/repository/equipment_repository.dart' as _i6;
import 'package:dnd_player_flutter/repository/races_repository.dart' as _i3;
import 'package:dnd_player_flutter/repository/settings_repository.dart' as _i2;
import 'package:dnd_player_flutter/repository/skills_repository.dart' as _i5;
import 'package:dnd_player_flutter/storage/character_outline.dart' as _i12;
import 'package:hive/hive.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeSettingsRepository_0 extends _i1.Fake
    implements _i2.SettingsRepository {}

class _FakeRacesRepository_1 extends _i1.Fake implements _i3.RacesRepository {}

class _FakeClassesRepository_2 extends _i1.Fake
    implements _i4.ClassesRepository {}

class _FakeSkillsRepository_3 extends _i1.Fake implements _i5.SkillsRepository {
}

class _FakeEquipmentRepository_4 extends _i1.Fake
    implements _i6.EquipmentRepository {}

class _FakeBox_5<E> extends _i1.Fake implements _i7.Box<E> {}

class _FakeProficiencyChoices_6 extends _i1.Fake
    implements _i8.ProficiencyChoices {}

class _FakeCost_7 extends _i1.Fake implements _i9.Cost {}

class _FakeEquipment_8 extends _i1.Fake implements _i9.Equipment {}

/// A class which mocks [CharacterRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCharacterRepository extends _i1.Mock
    implements _i10.CharacterRepository {
  MockCharacterRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SettingsRepository get settingsRepository =>
      (super.noSuchMethod(Invocation.getter(#settingsRepository),
          returnValue: _FakeSettingsRepository_0()) as _i2.SettingsRepository);
  @override
  _i3.RacesRepository get racesRepository =>
      (super.noSuchMethod(Invocation.getter(#racesRepository),
          returnValue: _FakeRacesRepository_1()) as _i3.RacesRepository);
  @override
  _i4.ClassesRepository get classesRepository =>
      (super.noSuchMethod(Invocation.getter(#classesRepository),
          returnValue: _FakeClassesRepository_2()) as _i4.ClassesRepository);
  @override
  _i5.SkillsRepository get skillsRepository =>
      (super.noSuchMethod(Invocation.getter(#skillsRepository),
          returnValue: _FakeSkillsRepository_3()) as _i5.SkillsRepository);
  @override
  _i6.EquipmentRepository get equipmentRepository => (super.noSuchMethod(
      Invocation.getter(#equipmentRepository),
      returnValue: _FakeEquipmentRepository_4()) as _i6.EquipmentRepository);
  @override
  _i7.Box<dynamic> get box => (super.noSuchMethod(Invocation.getter(#box),
      returnValue: _FakeBox_5<dynamic>()) as _i7.Box<dynamic>);
  @override
  set box(_i7.Box<dynamic>? _box) =>
      super.noSuchMethod(Invocation.setter(#box, _box),
          returnValueForMissingStub: null);
  @override
  void insertCharacter(_i11.Character? character) =>
      super.noSuchMethod(Invocation.method(#insertCharacter, [character]),
          returnValueForMissingStub: null);
  @override
  void addEquipmentToCharacter(
          _i11.Character? character, _i9.Equipment? equipment) =>
      super.noSuchMethod(
          Invocation.method(#addEquipmentToCharacter, [character, equipment]),
          returnValueForMissingStub: null);
  @override
  void removeEquipmentFromCharacter(
          _i11.Character? character, _i8.EquipmentQuantity? equipment) =>
      super.noSuchMethod(
          Invocation.method(
              #removeEquipmentFromCharacter, [character, equipment]),
          returnValueForMissingStub: null);
  @override
  void equipItem(_i11.Character? character, _i8.EquipmentQuantity? equipment) =>
      super.noSuchMethod(Invocation.method(#equipItem, [character, equipment]),
          returnValueForMissingStub: null);
  @override
  void unequipItem(
          _i11.Character? character, _i8.EquipmentQuantity? equipment) =>
      super.noSuchMethod(
          Invocation.method(#unequipItem, [character, equipment]),
          returnValueForMissingStub: null);
  @override
  List<String> getProficientSkillIndexes(_i11.Character? character) => (super
      .noSuchMethod(Invocation.method(#getProficientSkillIndexes, [character]),
          returnValue: <String>[]) as List<String>);
  @override
  List<_i12.EquipmentIndexQuantity> getCharacterEquipmentIndexQuantities(
          _i11.Character? character) =>
      (super
              .noSuchMethod(
                  Invocation.method(
                      #getCharacterEquipmentIndexQuantities, [character]),
                  returnValue: <_i12.EquipmentIndexQuantity>[])
          as List<_i12.EquipmentIndexQuantity>);
  @override
  void updatePreparedSpells(
          _i11.Character? character, List<_i13.Spell>? spells) =>
      super.noSuchMethod(
          Invocation.method(#updatePreparedSpells, [character, spells]),
          returnValueForMissingStub: null);
  @override
  List<String> getPreparedSpellsIndexes(_i11.Character? character) => (super
      .noSuchMethod(Invocation.method(#getPreparedSpellsIndexes, [character]),
          returnValue: <String>[]) as List<String>);
  @override
  void updateLearnedSpells(
          _i11.Character? character, List<_i13.Spell>? spells) =>
      super.noSuchMethod(
          Invocation.method(#updateLearnedSpells, [character, spells]),
          returnValueForMissingStub: null);
  @override
  List<String> getLearnedSpellsIndexes(_i11.Character? character) => (super
      .noSuchMethod(Invocation.method(#getLearnedSpellsIndexes, [character]),
          returnValue: <String>[]) as List<String>);
  @override
  void useSpellSlot(_i11.Character? character, int? level) =>
      super.noSuchMethod(Invocation.method(#useSpellSlot, [character, level]),
          returnValueForMissingStub: null);
  @override
  void unuseSpellSlot(_i11.Character? character, int? level) =>
      super.noSuchMethod(Invocation.method(#unuseSpellSlot, [character, level]),
          returnValueForMissingStub: null);
  @override
  _i14.Future<Map<int, int>> getUsedSpellSlots(_i11.Character? character) =>
      (super.noSuchMethod(Invocation.method(#getUsedSpellSlots, [character]),
              returnValue: Future<Map<int, int>>.value(<int, int>{}))
          as _i14.Future<Map<int, int>>);
  @override
  void setHp(_i11.Character? character, int? newHp) =>
      super.noSuchMethod(Invocation.method(#setHp, [character, newHp]),
          returnValueForMissingStub: null);
  @override
  _i14.Future<Map<int, int>> getMoney(_i11.Character? character) =>
      (super.noSuchMethod(Invocation.method(#getMoney, [character]),
              returnValue: Future<Map<int, int>>.value(<int, int>{}))
          as _i14.Future<Map<int, int>>);
  @override
  void earnMoney(_i11.Character? character, int? currency, int? amount) =>
      super.noSuchMethod(
          Invocation.method(#earnMoney, [character, currency, amount]),
          returnValueForMissingStub: null);
  @override
  void spendMoney(_i11.Character? character, int? currency, int? amount) =>
      super.noSuchMethod(
          Invocation.method(#spendMoney, [character, currency, amount]),
          returnValueForMissingStub: null);
  @override
  void addUserFeature(
          _i11.Character? character, _i15.UserFeature? userFeature) =>
      super.noSuchMethod(
          Invocation.method(#addUserFeature, [character, userFeature]),
          returnValueForMissingStub: null);
  @override
  List<_i15.UserFeature> getUserFeatures(_i11.Character? character) =>
      (super.noSuchMethod(Invocation.method(#getUserFeatures, [character]),
          returnValue: <_i15.UserFeature>[]) as List<_i15.UserFeature>);
  @override
  _i14.Future<List<_i11.Character>> getCharacters() => (super.noSuchMethod(
          Invocation.method(#getCharacters, []),
          returnValue: Future<List<_i11.Character>>.value(<_i11.Character>[]))
      as _i14.Future<List<_i11.Character>>);
}

/// A class which mocks [Class].
///
/// See the documentation for Mockito's code generation for more information.
class MockClass extends _i1.Mock implements _i8.Class {
  MockClass() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get index =>
      (super.noSuchMethod(Invocation.getter(#index), returnValue: '')
          as String);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  List<_i16.Characteristic> get savingThrows =>
      (super.noSuchMethod(Invocation.getter(#savingThrows),
          returnValue: <_i16.Characteristic>[]) as List<_i16.Characteristic>);
  @override
  _i8.ProficiencyChoices get proficiencyChoices =>
      (super.noSuchMethod(Invocation.getter(#proficiencyChoices),
          returnValue: _FakeProficiencyChoices_6()) as _i8.ProficiencyChoices);
  @override
  List<Map<String, String>> get equipmentProficiencies =>
      (super.noSuchMethod(Invocation.getter(#equipmentProficiencies),
          returnValue: <Map<String, String>>[]) as List<Map<String, String>>);
  @override
  String get imageAsset =>
      (super.noSuchMethod(Invocation.getter(#imageAsset), returnValue: '')
          as String);
  @override
  List<Object?> get props =>
      (super.noSuchMethod(Invocation.getter(#props), returnValue: <Object?>[])
          as List<Object?>);
}

/// A class which mocks [Race].
///
/// See the documentation for Mockito's code generation for more information.
class MockRace extends _i1.Mock implements _i17.Race {
  MockRace() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get index =>
      (super.noSuchMethod(Invocation.getter(#index), returnValue: '')
          as String);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  String get description =>
      (super.noSuchMethod(Invocation.getter(#description), returnValue: '')
          as String);
  @override
  int get baseSpeed =>
      (super.noSuchMethod(Invocation.getter(#baseSpeed), returnValue: 0)
          as int);
  @override
  String get abilityBonusDescription =>
      (super.noSuchMethod(Invocation.getter(#abilityBonusDescription),
          returnValue: '') as String);
  @override
  List<_i17.AbilityBonus> get abilityBonuses =>
      (super.noSuchMethod(Invocation.getter(#abilityBonuses),
          returnValue: <_i17.AbilityBonus>[]) as List<_i17.AbilityBonus>);
  @override
  String get age =>
      (super.noSuchMethod(Invocation.getter(#age), returnValue: '') as String);
  @override
  String get alignment =>
      (super.noSuchMethod(Invocation.getter(#alignment), returnValue: '')
          as String);
  @override
  _i17.Size get size => (super.noSuchMethod(Invocation.getter(#size),
      returnValue: _i17.Size.SMALL) as _i17.Size);
  @override
  String get sizeDescription =>
      (super.noSuchMethod(Invocation.getter(#sizeDescription), returnValue: '')
          as String);
  @override
  String get languagesDescription =>
      (super.noSuchMethod(Invocation.getter(#languagesDescription),
          returnValue: '') as String);
  @override
  List<Object?> get props =>
      (super.noSuchMethod(Invocation.getter(#props), returnValue: <Object?>[])
          as List<Object?>);
}

/// A class which mocks [Trait].
///
/// See the documentation for Mockito's code generation for more information.
class MockTrait extends _i1.Mock implements _i18.Trait {
  MockTrait() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get index =>
      (super.noSuchMethod(Invocation.getter(#index), returnValue: '')
          as String);
  @override
  List<_i18.TraitRace> get races =>
      (super.noSuchMethod(Invocation.getter(#races),
          returnValue: <_i18.TraitRace>[]) as List<_i18.TraitRace>);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  List<String> get description =>
      (super.noSuchMethod(Invocation.getter(#description),
          returnValue: <String>[]) as List<String>);
}

/// A class which mocks [Skill].
///
/// See the documentation for Mockito's code generation for more information.
class MockSkill extends _i1.Mock implements _i19.Skill {
  MockSkill() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get index =>
      (super.noSuchMethod(Invocation.getter(#index), returnValue: '')
          as String);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  _i16.Characteristic get characteristic =>
      (super.noSuchMethod(Invocation.getter(#characteristic),
          returnValue: _i16.Characteristic.STRENGTH) as _i16.Characteristic);
  @override
  List<Object?> get props =>
      (super.noSuchMethod(Invocation.getter(#props), returnValue: <Object?>[])
          as List<Object?>);
}

/// A class which mocks [Equipment].
///
/// See the documentation for Mockito's code generation for more information.
class MockEquipment extends _i1.Mock implements _i9.Equipment {
  MockEquipment() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get index =>
      (super.noSuchMethod(Invocation.getter(#index), returnValue: '')
          as String);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  _i9.EquipmentCategory get equipmentCategory =>
      (super.noSuchMethod(Invocation.getter(#equipmentCategory),
          returnValue: _i9.EquipmentCategory.WEAPON) as _i9.EquipmentCategory);
  @override
  _i9.Cost get cost =>
      (super.noSuchMethod(Invocation.getter(#cost), returnValue: _FakeCost_7())
          as _i9.Cost);
  @override
  bool get isEquippable =>
      (super.noSuchMethod(Invocation.getter(#isEquippable), returnValue: false)
          as bool);
  @override
  bool get isStackable =>
      (super.noSuchMethod(Invocation.getter(#isStackable), returnValue: false)
          as bool);
  @override
  List<Object?> get props =>
      (super.noSuchMethod(Invocation.getter(#props), returnValue: <Object?>[])
          as List<Object?>);
  @override
  _i9.Equipment copyWithContents(List<_i9.Equipment>? contents) =>
      (super.noSuchMethod(Invocation.method(#copyWithContents, [contents]),
          returnValue: _FakeEquipment_8()) as _i9.Equipment);
}
