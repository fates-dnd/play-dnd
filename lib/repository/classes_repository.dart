import 'dart:convert';

import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/dto/skill.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/mappers.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';

class ClassesRepository {
  final SkillsRepository skillsRepository;
  final EquipmentRepository equipmentRepository;
  final Future<String> Function(String lang) jsonReader;

  List<Class>? classes;
  String? language;

  ClassesRepository(
    this.skillsRepository,
    this.equipmentRepository,
    this.jsonReader,
  );

  Future<List<Class>> getClasses(String language) async {
    if (classes != null && this.language == language) {
      return classes!;
    }

    this.language = language;

    final response = await jsonReader(language);
    final List<dynamic> classesJson = json.decode(response);
    final futureClasses =
        Future.wait(classesJson.map((classJson) async => await _fromJson(
              language,
              classJson,
            )));

    classes = await futureClasses;
    return classes!;
  }

  Future<Class> findByIndex(String language, String index) async {
    final classes = await getClasses(language);
    return classes.firstWhere((element) => element.index == index);
  }

  Future<Class> _fromJson(String language, Map<String, dynamic> json) async {
    return Class(
        json["index"],
        json["name"],
        _readSavingThrows(json["saving_throws"] as List<dynamic>),
        _readSpellcastingAbility(json["spellcasting"]),
        await _readProficiencyChoices(
          language,
          json["proficiency_choices"] as List<dynamic>,
        ),
        await _readEquipments(language, json["starting_equipment"]),
        await _readEquipmentChoices(
            language, json["starting_equipment_options"]));
  }

  List<Characteristic> _readSavingThrows(List<dynamic> json) {
    return json.map((e) {
      final index = e["index"];
      return indexAsCharacteristic(index);
    }).toList();
  }

  Characteristic? _readSpellcastingAbility(dynamic json) {
    if (json == null) {
      return null;
    }
    final index = json["spellcasting_ability"]["index"];
    return indexAsCharacteristic(index);
  }

  Future<ProficiencyChoices> _readProficiencyChoices(
    String language,
    List<dynamic> choices,
  ) async {
    final skillChoices =
        choices.firstWhere((element) => element["type"] == "skills");
    return ProficiencyChoices(
      skillChoices["choose"],
      await _readSkills(
        language,
        skillChoices["from"] as List<dynamic>,
      ),
    );
  }

  Future<List<Skill>> _readSkills(
      String language, List<dynamic> fromSkills) async {
    final skills = await skillsRepository.getSkills(language);
    return fromSkills.map((e) {
      final index = e["index"];
      return skills.firstWhere((skill) => skill.index == index);
    }).toList();
  }

  Future<List<EquipmentQuantity>> _readEquipments(
      String language, List<dynamic>? startingEquipment) async {
    final allEquipment = await equipmentRepository.getEquipment(language);
    return startingEquipment?.map((json) {
          final index = json["equipment"]["index"];
          final quantity = json["quantity"] ?? 1;

          final foundEquipment =
              allEquipment.firstWhere((element) => element.index == index);

          return EquipmentQuantity(foundEquipment, quantity);
        }).toList() ??
        [];
  }

  Future<List<EquipmentChoices>> _readEquipmentChoices(
      String language, List<dynamic>? equipmentOptions) async {
    final allEquipment = await equipmentRepository.getEquipment(language);

    return equipmentOptions?.map((element) {
          // TODO: unwrap equipment categories
          final options = <EquipmentQuantity>[];
          if (element["from"] is Map) {
            return EquipmentChoices(element["choose"], []);
          }

          (element["from"] as List<dynamic>?)?.forEach((e) {
            if (e is Map) {
              if (e["equipment"] == null) {
                return;
              }

              final item = allEquipment.firstWhere(
                  (element) => element.index == e["equipment"]["index"]);
              options.add(EquipmentQuantity(item, e["quantity"] ?? 1));
            }

            if (e is List) {
              e.forEach((element) {
                if (element["equipment"] == null) {
                  return;
                }

                final item = allEquipment.firstWhere((equipment) =>
                    equipment.index == element["equipment"]["index"]);
                options.add(EquipmentQuantity(item, element["quantity"] ?? 1));
              });
            }
          });
          return EquipmentChoices(element["choose"], options);
        }).toList() ??
        [];
  }
}
