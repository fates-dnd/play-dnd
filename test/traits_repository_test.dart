import 'package:dnd_player_flutter/repository/traits_repository.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {

  TraitsRepository traitsRepository = _createRepository();

  setUp(() {
    traitsRepository = _createRepository();
  });

  test("load traits", () async {
    final traits = await traitsRepository.getTraits();
    
    expect(traits.length, 1);
    expect(traits[0].index, "stonecunning");
    expect(traits[0].name, "Знание Камня");
    expect(traits[0].races.length, 1);
    expect(traits[0].races[0].index, "dwarf");
    expect(traits[0].races[0].name, "Дварф");
    expect(traits[0].description, [
      "Если вы совершаете проверку Интеллекта (История), связанную с происхождением работы по камню, вы считаетесь владеющим навыком История, и добавляете к проверке удвоенный бонус владения вместо обычного бонуса."
    ]);
  });
}

TraitsRepository _createRepository() {
  return TraitsRepository(() async {
    return traitsJson;
  });
}

final traitsJson = """
    [{
      "index": "stonecunning",
      "races": [
        {
          "index": "dwarf",
          "name": "Дварф",
          "url": "/api/races/dwarf"
        }
      ],
      "subraces": [],
      "name": "Знание Камня",
      "desc": [
        "Если вы совершаете проверку Интеллекта (История), связанную с происхождением работы по камню, вы считаетесь владеющим навыком История, и добавляете к проверке удвоенный бонус владения вместо обычного бонуса."
      ],
      "proficiencies": [],
      "url": "/api/traits/stonecunning"
    }]
""";