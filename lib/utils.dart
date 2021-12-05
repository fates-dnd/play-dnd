import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/data/dice.dart';
import 'package:dnd_player_flutter/dto/damage_type.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension FirstWhereOrNullExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension ToBonusNumber on int {
  String toBonusString() {
    if (this >= 0) {
      return "+$this";
    } else {
      return this.toString();
    }
  }
}

extension CharacteristicColor on Characteristic {
  Color getColor() {
    return characteristicToColor[this] ?? Colors.yellow;
  }

  static Map<Characteristic, Color> characteristicToColor = {
    Characteristic.STRENGTH: Color(0xFFFF5251),
    Characteristic.DEXTERITY: Color(0xFF3AFFBD),
    Characteristic.CONSTITUTION: Color(0xFFFB9538),
    Characteristic.INTELLIGENCE: Color(0xFFE5E1DE),
    Characteristic.WISDOM: Color(0xFF4847FB),
    Characteristic.CHARISMA: Color(0xFFC01DFC),
  };
}

extension EquipmentWeaponRangeName on Equipment {
  String getWeaponRangeName(BuildContext context) {
    return (weaponRange == WeaponRange.MELEE
        ? AppLocalizations.of(context)!.melee
        : "${range?.normal} / ${range?.long}");
  }
}

extension EquipmentCategoryName on EquipmentCategory {
  String getName(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    switch (this) {
      case EquipmentCategory.WEAPON:
        return localization.weapon;
      case EquipmentCategory.ARMOR:
        return localization.armor;
      case EquipmentCategory.ADVENTURING_GEAR:
        return localization.adventuring_gear;
    }
  }
}

extension DamageTypeName on DamageType {
  String getName(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (this) {
      case DamageType.ACID:
        return localizations.acid;
      case DamageType.SLASHING:
        return localizations.slashing;
      case DamageType.NECROTIC:
        return localizations.necrotic;
      case DamageType.RADIANT:
        return localizations.radiant;
      case DamageType.FIRE:
        return localizations.fire;
      case DamageType.LIGHTNING:
        return localizations.lightning;
      case DamageType.POISON:
        return localizations.poison;
      case DamageType.COLD:
        return localizations.cold;
      case DamageType.BLUDGEONING:
        return localizations.bludgeoning;
      case DamageType.FORCE:
        return localizations.force;
      case DamageType.PSYCHIC:
        return localizations.psychic;
      case DamageType.PIERCING:
        return localizations.piercing;
      case DamageType.THUNDER:
        return localizations.thunder;
    }
  }
}

extension DiceName on Dice {
  String getName(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (this) {
      case Dice.D4:
        return localizations.d4;
      case Dice.D6:
        return localizations.d6;
      case Dice.D8:
        return localizations.d8;
      case Dice.D10:
        return localizations.d10;
      case Dice.D12:
        return localizations.d12;
      case Dice.D20:
        return localizations.d20;
      case Dice.D100:
        return localizations.d100;
    }
  }
}
