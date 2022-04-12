import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/repository/races_repository.dart';
import 'package:test/test.dart';

void main() {
  RacesRepository racesRepository;

  test('load races', () async {
    racesRepository = _createRepository(racesJson);

    final races = await racesRepository.getRaces("en");

    expect(races.length, 1);
    expect(races[0].name, "Дварф");
    expect(races[0].baseSpeed, 25);
    expect(races[0].alignment,
        "Большинство дварфов законопослушные, твёрдо верящие в преимущества хорошо организованного общества. Они также стремятся к добру, обладают развитым чувством справедливости и верят, что все заслуживают пользования преимуществами закона и порядка.");
    expect(races[0].size, Size.MEDIUM);
    expect(races[0].sizeDescription,
        "Рост дварфов находится между 4 и 5 футами, и весят они около 150 фунтов. Ваш размер — Средний.");
    expect(races[0].languagesDescription,
        "Вы разговариваете, читаете и пишете на Общем и Дварфийском языках. Дварфийский язык состоит из твёрдых согласных и гортанных звуков,и этот акцент будет присутствовать в любомязыке, на котором дварф будет говорить.");
    expect(races[0].abilityBonusDescription,
        "Значение вашей Выносливости увеличивается на 2.");
    expect(races[0].abilityBonuses.length, 1);
    expect(races[0].abilityBonuses[0].abilityScore.index, "con");
    expect(races[0].abilityBonuses[0].bonus, 2);
    expect(races[0].abilityBonusOptions, null);
  });

  test('race with ability bonus options', () async {
    racesRepository = _createRepository(halfElfJson);
    final races = await racesRepository.getRaces("en");

    expect(races.length, 1);
    expect(races[0].abilityBonusOptions?.choose, 2);
    expect(races[0].abilityBonusOptions?.abilityBonuses.length, 5);
  });
}

RacesRepository _createRepository(String input) {
  return RacesRepository((language) async {
    return input;
  });
}

final racesJson = """
    [{
      "index": "dwarf",
      "name": "Дварф",
      "description": "Полные древнего величия королевства и вырезанные в толще гор чертоги, удары кирок и молотков, раздающиеся в глубоких шахтах и пылающий кузнечный горн, верность клану и традициям и пылающая ненависть к гоблинам и оркам — вот вещи, объединяющие всех дварфов.",
      "speed": 25,
      "ability_bonuses": [
        {
          "ability_score": {
            "index": "con",
            "name": "Выносливость",
            "url": "/api/ability-scores/con"
          },
          "bonus": 2
        }
      ],
      "ability_bonus_description": "Значение вашей Выносливости увеличивается на 2.",
      "alignment": "Большинство дварфов законопослушные, твёрдо верящие в преимущества хорошо организованного общества. Они также стремятся к добру, обладают развитым чувством справедливости и верят, что все заслуживают пользования преимуществами закона и порядка.",
      "age": "Дварфы взрослеют с той же скоростью, что и люди, но они считаются молодыми, пока не достигнут возраста 50 лет. В среднем, они живут свыше 350 лет.",
      "size": "Medium",
      "size_description": "Рост дварфов находится между 4 и 5 футами, и весят они около 150 фунтов. Ваш размер — Средний.",
      "starting_proficiencies": [
        {
          "index": "battleaxes",
          "name": "Боевой топор",
          "url": "/api/proficiencies/battleaxes"
        },
        {
          "index": "handaxes",
          "name": "Ручной топор",
          "url": "/api/proficiencies/handaxes"
        },
        {
          "index": "light-hammers",
          "name": "Легкий топор",
          "url": "/api/proficiencies/light-hammers"
        },
        {
          "index": "warhammers",
          "name": "Боевой молот",
          "url": "/api/proficiencies/warhammers"
        }
      ],
      "starting_proficiency_options": {
        "choose": 1,
        "type": "proficiencies",
        "from": [
          {
            "index": "smiths-tools",
            "name": "Инструменты Кузнеца",
            "url": "/api/proficiencies/smiths-tools"
          },
          {
            "index": "brewers-supplies",
            "name": "Инструменты Пивовара",
            "url": "/api/proficiencies/brewers-supplies"
          },
          {
            "index": "masons-tools",
            "name": "Инструменты Каменщика",
            "url": "/api/proficiencies/masons-tools"
          }
        ]
      },
      "languages": [
        {
          "index": "common",
          "name": "Общий",
          "url": "/api/languages/common"
        },
        {
          "index": "dwarvish",
          "name": "Дварфийский",
          "url": "/api/languages/dwarvish"
        }
      ],
      "language_desc": "Вы разговариваете, читаете и пишете на Общем и Дварфийском языках. Дварфийский язык состоит из твёрдых согласных и гортанных звуков,и этот акцент будет присутствовать в любомязыке, на котором дварф будет говорить.",
      "traits": [
        {
          "index": "darkvision",
          "name": "Темное зрение",
          "url": "/api/traits/darkvision"
        },
        {
          "index": "dwarven-resilience",
          "name": "Дварфская стойкость",
          "url": "/api/traits/dwarven-resilience"
        },
        {
          "index": "stonecunning",
          "name": "Знание Камня",
          "url": "/api/traits/stonecunning"
        },
        {
          "index": "dwarven-combat-training",
          "name": "Дварфийская Боевая Тренировка",
          "url": "/api/traits/dwarven-combat-training"
        },
        {
          "index": "tool-proficiency",
          "name": "Владение инструментами",
          "url": "/api/traits/tool-proficiency"
        }
      ],
      "subraces": [
        {
          "index": "hill-dwarf",
          "name": "Холмовой Дварф",
          "url": "/api/subraces/hill-dwarf"
        }
      ],
      "url": "/api/races/dwarf"
    }]
    """;

final halfElfJson = """
[  {
    "index": "half-elf",
    "name": "Полуэльф",
    "description": "Бродящие по двум мирам, но в действительности, не принадлежащие ни одному из них. Полуэльфы сочетают в себе, как некоторые говорят, лучшие качества обеих рас: человеческие любознательность, изобретательность и амбиции, приправленные изысканными чувствами, любовью к природе и ощущением прекрасного, свойственными эльфам. Некоторые полуэльфы живут среди людей, отгороженные эмоциональными и физическими различиями, наблюдая за старением друзей и возлюбленных, лишь слегка тронутые временем. Другие живут с эльфами в неподвластных времени эльфийских королевствах. Они стремительно растут, и достигают зрелости, пока их сверстники ещё остаются детьми. Многие полуэльфы не способны ужиться ни в одном обществе, и выбирают жизнь одиноких странников или объединяются с другими изгнанниками и неудачниками, чтобы отправиться к приключениям.",
    "speed": 30,
    "ability_bonuses": [
      {
        "ability_score": {
          "index": "cha",
          "name": "Харизма",
          "url": "/api/ability-scores/cha"
        },
        "bonus": 2
      }
    ],
    "ability_bonus_options": {
      "choose": 2,
      "type": "ability_bonuses",
      "from": [
        {
          "ability_score": {
            "index": "str",
            "name": "Сила",
            "url": "/api/ability-scores/str"
          },
          "bonus": 1
        },
        {
          "ability_score": {
            "index": "dex",
            "name": "Ловкость",
            "url": "/api/ability-scores/dex"
          },
          "bonus": 1
        },
        {
          "ability_score": {
            "index": "con",
            "name": "Выносливость",
            "url": "/api/ability-scores/con"
          },
          "bonus": 1
        },
        {
          "ability_score": {
            "index": "int",
            "name": "Интеллект",
            "url": "/api/ability-scores/int"
          },
          "bonus": 1
        },
        {
          "ability_score": {
            "index": "wis",
            "name": "Мудрость",
            "url": "/api/ability-scores/wis"
          },
          "bonus": 1
        }
      ]
    },
    "ability_bonus_description": "Значение вашей Харизмы увеличивается на 2, а значения двух других характеристик на ваш выбор увеличиваются на 1.",
    "alignment": "Полуэльфы унаследовали склонность к хаосу от своих эльфийских предков. Они одинаково ценят и личную свободу и творческое самовыражение, не проявляя ни тяги к лидерству, ни желания следовать за лидером. Их раздражают правила и чужие требования, и иногда они оказываются ненадёжными или непредсказуемыми.",
    "age": "Полуэльфы взрослеют с той же скоростью, что и люди, и достигают зрелости к 20 годам. Они живут гораздо дольше людей, часто пересекая рубеж в 180 лет.",
    "size": "Medium",
    "size_description": "Полуэльфы почти такого же размера,как и люди. Их рост колеблется от 5 до 6 футов (от 155 до 183 сантиметров). Ваш размер — Средний.",
    "starting_proficiencies": [],
    "starting_proficiency_options": {
      "choose": 2,
      "type": "proficiencies",
      "from": [
        {
          "index": "skill-acrobatics",
          "name": "Навык: Акробатика",
          "url": "/api/proficiencies/skill-acrobatics"
        },
        {
          "index": "skill-animal-handling",
          "name": "Навык: Обращение с Животными",
          "url": "/api/proficiencies/skill-animal-handling"
        },
        {
          "index": "skill-arcana",
          "name": "Навык: Магия",
          "url": "/api/proficiencies/skill-arcana"
        },
        {
          "index": "skill-athletics",
          "name": "Навык: Атлетика",
          "url": "/api/proficiencies/skill-athletics"
        },
        {
          "index": "skill-deception",
          "name": "Навык: Обман",
          "url": "/api/proficiencies/skill-deception"
        },
        {
          "index": "skill-history",
          "name": "Навык: История",
          "url": "/api/proficiencies/skill-history"
        },
        {
          "index": "skill-insight",
          "name": "Навык: Проницательность",
          "url": "/api/proficiencies/skill-insight"
        },
        {
          "index": "skill-intimidation",
          "name": "Навык: Запугивание",
          "url": "/api/proficiencies/skill-intimidation"
        },
        {
          "index": "skill-investigation",
          "name": "Навык: Расследование",
          "url": "/api/proficiencies/skill-investigation"
        },
        {
          "index": "skill-medicine",
          "name": "Навык: Медицина",
          "url": "/api/proficiencies/skill-medicine"
        },
        {
          "index": "skill-nature",
          "name": "Навык: Природа",
          "url": "/api/proficiencies/skill-nature"
        },
        {
          "index": "skill-perception",
          "name": "Навык: Восприятие",
          "url": "/api/proficiencies/skill-perception"
        },
        {
          "index": "skill-performance",
          "name": "Навык: Выступление",
          "url": "/api/proficiencies/skill-performance"
        },
        {
          "index": "skill-persuasion",
          "name": "Навык: Убеждение",
          "url": "/api/proficiencies/skill-persuasion"
        },
        {
          "index": "skill-religion",
          "name": "Навык: Религия",
          "url": "/api/proficiencies/skill-religion"
        },
        {
          "index": "skill-sleight-of-hand",
          "name": "Навык: Ловкость Рук",
          "url": "/api/proficiencies/skill-sleight-of-hand"
        },
        {
          "index": "skill-stealth",
          "name": "Навык: Скрытность",
          "url": "/api/proficiencies/skill-stealth"
        },
        {
          "index": "skill-survival",
          "name": "Навык: Выживание",
          "url": "/api/proficiencies/skill-survival"
        }
      ]
    },
    "languages": [
      {
        "index": "common",
        "name": "Общий",
        "url": "/api/languages/common"
      },
      {
        "index": "elvish",
        "name": "Эльфийский",
        "url": "/api/languages/elvish"
      }
    ],
    "language_options": {
      "choose": 1,
      "type": "languages",
      "from": [
        {
          "index": "dwarvish",
          "name": "Дварфийский",
          "url": "/api/languages/dwarvish"
        },
        {
          "index": "giant",
          "name": "Великаний",
          "url": "/api/languages/giant"
        },
        {
          "index": "gnomish",
          "name": "Гномий",
          "url": "/api/languages/gnomish"
        },
        {
          "index": "goblin",
          "name": "Гоблинский",
          "url": "/api/languages/goblin"
        },
        {
          "index": "halfling",
          "name": "Полуросликов",
          "url": "/api/languages/halfling"
        },
        {
          "index": "orc",
          "name": "Орочий",
          "url": "/api/languages/orc"
        },
        {
          "index": "abyssal",
          "name": "Язык Бездны",
          "url": "/api/languages/abyssal"
        },
        {
          "index": "celestial",
          "name": "Небесный",
          "url": "/api/languages/celestial"
        },
        {
          "index": "draconic",
          "name": "Драконий",
          "url": "/api/languages/draconic"
        },
        {
          "index": "deep-speech",
          "name": "Глубинная Речь",
          "url": "/api/languages/deep-speech"
        },
        {
          "index": "infernal",
          "name": "Инфернальный",
          "url": "/api/languages/infernal"
        },
        {
          "index": "primordial",
          "name": "Первичный",
          "url": "/api/languages/primordial"
        },
        {
          "index": "sylvan",
          "name": "Сильван",
          "url": "/api/languages/sylvan"
        },
        {
          "index": "undercommon",
          "name": "Подземный",
          "url": "/api/languages/undercommon"
        }
      ]
    },
    "language_desc": "Вы можете говорить, читать и писать на Общем, Эльфийском, и ещё одном языке на ваш выбор.",
    "traits": [
      {
        "index": "darkvision",
        "name": "Темное зрение",
        "url": "/api/traits/darkvision"
      },
      {
        "index": "fey-ancestry",
        "name": "Наследие фей",
        "url": "/api/traits/fey-ancestry"
      },
      {
        "index": "skill-versatility",
        "name": "Гибкость навыков",
        "url": "/api/traits/skill-versatility"
      }
    ],
    "subraces": [],
    "url": "/api/races/half-elf"
  }]
""";
