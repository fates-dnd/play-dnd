import 'package:dnd_player_flutter/dto/skill.dart';

class SkillBonus {
  final Skill skill;
  final int bonus;
  final bool proficient;

  SkillBonus(
    this.skill,
    this.bonus,
    this.proficient,
  );
}
