part of 'selected_proficiencies_bloc.dart';

class SelectedProficienciesState extends Equatable {
  final int choose;
  final int chooseForBackground;

  final List<Skill?> selected;
  final List<List<Skill>> available;

  SelectedProficienciesState({
    this.choose = 0,
    this.chooseForBackground = 0,
    this.selected = const [],
    this.available = const [],
  });

  bool get areSkillsSelected => !selected.any((element) => element == null);

  List<Skill?> get selectedForClass => selected.sublist(0, choose);

  List<Skill?> get selectedForBackground => selected.sublist(choose);

  @override
  List<Object?> get props => [
        choose,
        selected,
        available,
      ];
}
