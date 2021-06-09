class Trait {

  final String index;
  final List<TraitRace> races;
  final String name;
  final List<String> description;

  Trait(this.index, this.races, this.name, this.description);
}

class TraitRace {

  final String index;
  final String name;

  TraitRace(this.index, this.name);
}
