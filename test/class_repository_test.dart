import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/repository/classes_repository.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {

  ClassesRepository classesRepository = _createRepository();

  setUp(() {
    classesRepository = _createRepository();
  });

  test('load classes', () async {
    final classes = await classesRepository.getClasses();

    expect(classes.length, 1);
    expect(classes[0].index, "bard");
    expect(classes[0].name, "Бард");
    expect(classes[0].savingThrows.length, 2);
    expect(classes[0].savingThrows[0], Characteristic.DEXTERITY);
    expect(classes[0].savingThrows[1], Characteristic.CHARISMA);
  });
}

ClassesRepository _createRepository() {
  return ClassesRepository(() async {
    return classesJson;
  });
}

final classesJson = """
[{
    "index": "bard",
    "name": "Бард",
    "hit_die": 8,
    "proficiency_choices": [
        {
            "choose": 3,
            "type": "proficiencies",
            "from": [
                {
                    "index": "skill-acrobatics",
                    "name": "Skill: Acrobatics",
                    "url": "/api/proficiencies/skill-acrobatics"
                },
                {
                    "index": "skill-animal-handling",
                    "name": "Skill: Animal Handling",
                    "url": "/api/proficiencies/skill-animal-handling"
                },
                {
                    "index": "skill-arcana",
                    "name": "Skill: Arcana",
                    "url": "/api/proficiencies/skill-arcana"
                },
                {
                    "index": "skill-athletics",
                    "name": "Skill: Athletics",
                    "url": "/api/proficiencies/skill-athletics"
                },
                {
                    "index": "skill-deception",
                    "name": "Skill: Deception",
                    "url": "/api/proficiencies/skill-deception"
                },
                {
                    "index": "skill-history",
                    "name": "Skill: History",
                    "url": "/api/proficiencies/skill-history"
                },
                {
                    "index": "skill-insight",
                    "name": "Skill: Insight",
                    "url": "/api/proficiencies/skill-insight"
                },
                {
                    "index": "skill-intimidation",
                    "name": "Skill: Intimidation",
                    "url": "/api/proficiencies/skill-intimidation"
                },
                {
                    "index": "skill-investigation",
                    "name": "Skill: Investigation",
                    "url": "/api/proficiencies/skill-investigation"
                },
                {
                    "index": "skill-medicine",
                    "name": "Skill: Medicine",
                    "url": "/api/proficiencies/skill-medicine"
                },
                {
                    "index": "skill-nature",
                    "name": "Skill: Nature",
                    "url": "/api/proficiencies/skill-nature"
                },
                {
                    "index": "skill-perception",
                    "name": "Skill: Perception",
                    "url": "/api/proficiencies/skill-perception"
                },
                {
                    "index": "skill-performance",
                    "name": "Skill: Performance",
                    "url": "/api/proficiencies/skill-performance"
                },
                {
                    "index": "skill-persuasion",
                    "name": "Skill: Persuasion",
                    "url": "/api/proficiencies/skill-persuasion"
                },
                {
                    "index": "skill-religion",
                    "name": "Skill: Religion",
                    "url": "/api/proficiencies/skill-religion"
                },
                {
                    "index": "skill-sleight-of-hand",
                    "name": "Skill: Sleight of Hand",
                    "url": "/api/proficiencies/skill-sleight-of-hand"
                },
                {
                    "index": "skill-stealth",
                    "name": "Skill: Stealth",
                    "url": "/api/proficiencies/skill-stealth"
                },
                {
                    "index": "skill-survival",
                    "name": "Skill: Survival",
                    "url": "/api/proficiencies/skill-survival"
                }
            ]
        },
        {
            "choose": 3,
            "type": "proficiencies",
            "from": [
                {
                    "index": "bagpipes",
                    "name": "Волынка",
                    "url": "/api/proficiencies/bagpipes"
                },
                {
                    "index": "drum",
                    "name": "Барабан",
                    "url": "/api/proficiencies/drum"
                },
                {
                    "index": "dulcimer",
                    "name": "Цимбалы",
                    "url": "/api/proficiencies/dulcimer"
                },
                {
                    "index": "flute",
                    "name": "Флейта",
                    "url": "/api/proficiencies/flute"
                },
                {
                    "index": "lute",
                    "name": "Лютня",
                    "url": "/api/proficiencies/lute"
                },
                {
                    "index": "lyre",
                    "name": "Лира",
                    "url": "/api/proficiencies/lyre"
                },
                {
                    "index": "horn",
                    "name": "Рог",
                    "url": "/api/proficiencies/horn"
                },
                {
                    "index": "pan-flute",
                    "name": "Пан флейта",
                    "url": "/api/proficiencies/pan-flute"
                },
                {
                    "index": "shawm",
                    "name": "Шалмей",
                    "url": "/api/proficiencies/shawm"
                },
                {
                    "index": "viol",
                    "name": "Виола",
                    "url": "/api/proficiencies/viol"
                }
            ]
        }
    ],
    "proficiencies": [
        {
            "index": "light-armor",
            "name": "Легкая броня",
            "url": "/api/proficiencies/light-armor"
        },
        {
            "index": "simple-weapons",
            "name": "Простое оружие",
            "url": "/api/proficiencies/simple-weapons"
        },
        {
            "index": "longswords",
            "name": "Длинный меч",
            "url": "/api/proficiencies/longswords"
        },
        {
            "index": "rapiers",
            "name": "Рапира",
            "url": "/api/proficiencies/rapiers"
        },
        {
            "index": "shortswords",
            "name": "Короткий меч",
            "url": "/api/proficiencies/shortswords"
        },
        {
            "index": "crossbows-hand",
            "name": "Ручной арбалет",
            "url": "/api/proficiencies/crossbows-hand"
        }
    ],
    "saving_throws": [
        {
            "index": "dex",
            "name": "Ловкость",
            "url": "/api/ability-scores/dex"
        },
        {
            "index": "cha",
            "name": "Харизма",
            "url": "/api/ability-scores/cha"
        }
    ],
    "starting_equipment": [
        {
            "equipment": {
                "index": "leather",
                "name": "Кожа",
                "url": "/api/equipment/leather"
            },
            "quantity": 1
        },
        {
            "equipment": {
                "index": "dagger",
                "name": "Кинжал",
                "url": "/api/equipment/dagger"
            },
            "quantity": 1
        }
    ],
    "starting_equipment_options": [
        {
            "choose": 1,
            "type": "equipment",
            "from": [
                {
                    "equipment": {
                        "index": "rapier",
                        "name": "Рапира",
                        "url": "/api/equipment/rapier"
                    },
                    "quantity": 1
                },
                {
                    "equipment": {
                        "index": "longsword",
                        "name": "Длинный меч",
                        "url": "/api/equipment/longsword"
                    },
                    "quantity": 1
                },
                {
                    "equipment_option": {
                        "choose": 1,
                        "type": "equipment",
                        "from": {
                            "equipment_category": {
                                "index": "simple-weapons",
                                "name": "Простое оружие",
                                "url": "/api/equipment-categories/simple-weapons"
                            }
                        }
                    }
                }
            ]
        },
        {
            "choose": 1,
            "type": "equipment",
            "from": [
                {
                    "equipment": {
                        "index": "diplomats-pack",
                        "name": "Набор дипломата",
                        "url": "/api/equipment/diplomats-pack"
                    },
                    "quantity": 1
                },
                {
                    "equipment": {
                        "index": "entertainers-pack",
                        "name": "Набор развлекателя",
                        "url": "/api/equipment/entertainers-pack"
                    },
                    "quantity": 1
                }
            ]
        },
        {
            "choose": 1,
            "type": "equipment",
            "from": [
                {
                    "equipment": {
                        "index": "lute",
                        "name": "Лютня",
                        "url": "/api/equipment/lute"
                    }
                },
                {
                    "equipment_option": {
                        "choose": 1,
                        "type": "equipment",
                        "from": {
                            "equipment_category": {
                                "index": "musical-instruments",
                                "name": "Музыкальный инструмент",
                                "url": "/api/equipment-categories/musical-instruments"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "class_levels": "/api/classes/bard/levels",
    "subclasses": [
        {
            "index": "lore",
            "name": "Коллегия знаний",
            "url": "/api/subclasses/lore"
        }
    ],
    "spellcasting": {
        "level": 1,
        "spellcasting_ability": {
            "index": "cha",
            "name": "Харизма",
            "url": "/api/ability-scores/cha"
        },
        "info": [
            {
                "name": "Заговоры",
                "desc": [
                    "Вы знаете два заговора из списка доступных для барда на ваш выбор. Вы выучите дополнительные заговоры барда по вашему выбору на более высоких уровнях, как это показано в стоблце Известные заговоры таблицы Барда."
                ]
            },
            {
                "name": "Ячейки заклинаний",
                "desc": [
                    "Таблица «Бард» показывает, сколько ячеек заклинаний у вас есть для заклинаний 1 и других кругов. Для использования заклинания вы должны потратить ячейку соответствующего, либо превышающего уровня. Вы восстанавливаете все потраченные ячейки заклинаний после завершения длинного отдыха.",
                    "Например, если вы знаете заклинание 1 круга лечение ран, и у вас есть ячейки 1 и 2 кругов, вы можете использовать лечение ран с помощью любой из этих ячеек."
                ]
            },
            {
                "name": "Известные заклинания первого и более высоких кругов",
                "desc": [
                    "Вы знаете четыре заклинания 1 круга на свой выбор из списка доступных барду.",
                    "Столбец «Известные заклинания» барда показывает, когда вы сможете выучить новые заклинания. Круг заклинаний не должен превышать круг самой высокой имеющейся у вас ячейки заклинаний. Например, когда вы достигнете 3 уровня в этом классе, вы можете выучить одно новое заклинание 1 или 2 круга.",
                    "Кроме того, когда вы получаете уровень в этом классе, вы можете выбрать одно из известных вам заклинаний барда и заменить его другим заклинанием из списка заклинаний барда, который также должен иметь уровень, для которого у вас есть слоты заклинаний."
                ]
            },
            {
                "name": "Заклинательная характеристика",
                "desc": [
                    "При сотворении заклинаний бард использует свою Харизму. Ваша магия проистекает из сердечности и душевности, которую вы вкладываете в исполнение музыки и произнесение речей. Вы используете Харизму в случаях, когда заклинание ссылается на Заклинательную характеристику. Кроме того,вы используете Харизму при определении УС спасбросков от ваших заклинаний барда, и при броске атаки заклинаниями.",
                    "УС спасбросков заклинаний = 8 + бонус владения + модификатор Харизмы",
                    "Модификатор атаки заклинанием = бонус владения + модификатор Харизмы"
                ]
            },
            {
                "name": "Ритуальное сотворение",
                "desc": [
                    "Вы можете сотворить любое известное вам заклинание барда в качестве ритуала, если заклинание позволяет это."
                ]
            },
            {
                "name": "Заклинательный фокус",
                "desc": [
                    "Вы можете использовать ваш музыкальный инструмент (смотрите в «Снаряжении») в качестве фокуса для ваших заклинаний барда."
                ]
            }
        ]
    },
    "spells": "/api/classes/bard/spells",
    "url": "/api/classes/bard"
}]
""";