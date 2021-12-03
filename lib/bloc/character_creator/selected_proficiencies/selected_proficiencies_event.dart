part of 'selected_proficiencies_bloc.dart';

@immutable
abstract class SelectedProficienciesEvent {}

class SelectSkillProficiency extends SelectedProficienciesEvent {
  final int index;
  final Skill skill;

  SelectSkillProficiency(this.index, this.skill);
}
