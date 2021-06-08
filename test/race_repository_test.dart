import 'package:dnd_player_flutter/repository/races_repository.dart';
import 'package:test/test.dart';

void main() {
  RacesRepository racesRepository = RacesRepository(() async {
    return racesJson;
  });

  setUp(() {
    racesRepository = RacesRepository(() async {
      return racesJson;
    });
  });

  test('load races', () async {
    final races = await racesRepository.getRaces();

    expect(races.length, 1);
    expect(races[0].name, "Дварф");
    expect(races[0].baseSpeed, 25);
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
