part of 'selected_proficiencies_bloc.dart';

class SelectedProficienciesState extends Equatable {
  final int choose;
  final List<Skill?> selected;
  final List<List<Skill>> available;

  SelectedProficienciesState(
    this.choose,
    this.selected,
    this.available,
  );

  @override
  List<Object?> get props => [choose, selected, available];
}
