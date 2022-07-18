part of 'character_bloc.dart';

@immutable
abstract class CharacterEvent {}

class SetCharacter extends CharacterEvent {
  final Character character;

  SetCharacter(this.character);
}

class AddEquipmentItem extends CharacterEvent {
  final Equipment equipment;

  AddEquipmentItem(this.equipment);
}

class RemoveEquipmentItem extends CharacterEvent {
  final EquipmentQuantity equipment;

  RemoveEquipmentItem(this.equipment);
}

class EquipItem extends CharacterEvent {
  final EquipmentQuantity equipment;

  EquipItem(this.equipment);
}

class UnequipItem extends CharacterEvent {
  final EquipmentQuantity equipment;

  UnequipItem(this.equipment);
}

class UpdateSpells extends CharacterEvent {
  final List<Spell> preparedSpells;
  final List<Spell> learnedSpells;

  UpdateSpells(this.preparedSpells, this.learnedSpells);
}

class UseSpellSlot extends CharacterEvent {
  final int spellLevel;

  UseSpellSlot(this.spellLevel);
}

class UnuseSpellSlot extends CharacterEvent {
  final int spellLevel;

  UnuseSpellSlot(this.spellLevel);
}

class Heal extends CharacterEvent {
  final int amount;

  Heal(this.amount);
}

class Damage extends CharacterEvent {
  final int amount;

  Damage(this.amount);
}

class EarnMoney extends CharacterEvent {
  final Currency currency;
  final int amount;

  EarnMoney(this.currency, this.amount);
}

class SpendMoney extends CharacterEvent {
  final Currency currency;
  final int amount;

  SpendMoney(this.currency, this.amount);
}

class AddUserFeature extends CharacterEvent {
  final UserFeature userFeature;

  AddUserFeature(this.userFeature);
}

class SpendUserFeature extends CharacterEvent {
  final UserFeature userFeature;

  SpendUserFeature(this.userFeature);
}

class RecoverUserFeature extends CharacterEvent {
  final UserFeature userFeature;

  RecoverUserFeature(this.userFeature);
}

class UpdateUserFeature extends CharacterEvent {
  final UserFeature oldFeature;
  final UserFeature newFeature;

  UpdateUserFeature(this.oldFeature, this.newFeature);
}

class LevelUpWithHp extends CharacterEvent {
  final int newHp;

  LevelUpWithHp(this.newHp);
}

class ImproveAbilityScores extends CharacterEvent {
  final Characteristic option1;
  final Characteristic option2;

  ImproveAbilityScores(this.option1, this.option2);
}
