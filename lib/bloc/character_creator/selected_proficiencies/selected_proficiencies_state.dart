part of 'selected_proficiencies_bloc.dart';

class SelectedProficienciesState {
  final int choose;
  final List<Skill?> selected;
  final List<Skill> available;

  SelectedProficienciesState(
    this.choose,
    this.selected,
    this.available,
  );
}
