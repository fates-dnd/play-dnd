import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/bloc/character/unarmed_attack.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/ui/equipment/equipment_list.dart';
import 'package:dnd_player_flutter/ui/equipment/sure_to_delete_equipment.dart';
import 'package:dnd_player_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EquipmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext rootContext) {
    final localizations = AppLocalizations.of(rootContext)!;

    return ListView(
      children: [
        EquippedSection(),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(rootContext)
                    .push(MaterialPageRoute(builder: (context) {
                  return EquipmentList(
                    onEquipmentSelected: (item) {
                      BlocProvider.of<CharacterBloc>(rootContext)
                          .add(AddEquipmentItem(item));
                    },
                  );
                }));
              },
              child: Text(localizations.add),
            ),
          ],
        ),
        SizedBox(height: 14),
        AllItemsSection(),
      ],
    );
  }
}

class EquippedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.primaryColorLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.equipment,
              style: theme.textTheme.headline2,
            ),
            Row(
              children: [
                Expanded(flex: 3, child: SizedBox()),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "Атака",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFDCDAD9),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      localizations.damage,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFDCDAD9),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            UnarmedAttackRow(
              unarmedAttack: state.unarmedAttack,
            ),
            for (var i = 0; i < (state.equippedItems?.length ?? 0); ++i)
              EquippedItem(
                  equipmentQuantity: state.equippedItems![i], state: state),
          ],
        ),
      ),
    );
  }
}

class EquippedItem extends StatelessWidget {
  final EquipmentQuantity equipmentQuantity;
  final CharacterState state;

  const EquippedItem({
    Key? key,
    required this.equipmentQuantity,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final equipment = equipmentQuantity.equipment;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  equipment.name,
                  style: TextStyle(
                    color: Color(0xDDDCDAD9),
                    fontSize: 18,
                  ),
                ), // name
                SizedBox(
                  height: 2,
                ),
                if (equipment.weaponRange != null)
                  Text(
                    equipment.getWeaponRangeName(context),
                    style: TextStyle(
                      color: Color(0xAADCDAD9),
                      fontSize: 12,
                    ),
                  ), // range
              ],
            ),
          ),

          if (equipment.damage != null)
            Expanded(
                flex: 1,
                child: Center(
                    child: ActionableInfo(
                        content: state
                            .getAttackBonus(equipment)
                            .toBonusString()))), // attack roll

          if (equipment.damage != null)
            Expanded(
                flex: 1,
                child: Center(
                    child: ActionableInfo(
                        content: _damageToString(
                            context, state, equipment)))), // damage roll
        ],
      ),
    );
  }

  String _damageToString(
      BuildContext context, CharacterState state, Equipment equipment) {
    final damage = equipment.damage;
    if (damage == null) {
      return "";
    }
    return "${damage.damageDice.amount}${damage.damageDice.dice.getName(context)}${state.getDamageBonus(equipment).toBonusString()}";
  }
}

class UnarmedAttackRow extends StatelessWidget {
  final UnarmedAttack unarmedAttack;

  const UnarmedAttackRow({Key? key, required this.unarmedAttack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.unarmed_strike,
                  style: TextStyle(
                    color: Color(0xDDDCDAD9),
                    fontSize: 18,
                  ),
                ), // name
                SizedBox(
                  height: 2,
                ),
                Text(
                  localizations.melee,
                  style: TextStyle(
                    color: Color(0xAADCDAD9),
                    fontSize: 12,
                  ),
                ), // range
              ],
            ),
          ),

          Expanded(
              flex: 1,
              child: Center(
                  child: ActionableInfo(
                      content: unarmedAttack.attackBonus
                          .toBonusString()))), // attack roll
          Expanded(
              flex: 1,
              child: Center(
                  child: ActionableInfo(
                      content: unarmedAttack.damage?.toString() ??
                          "0"))), // damage roll
        ],
      ),
    );
  }
}

class ActionableInfo extends StatelessWidget {
  final String content;

  const ActionableInfo({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF1A1E21),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        content,
        style: TextStyle(
          color: Color(0xFFDCDAD9),
          fontSize: 14,
        ),
      ),
    );
  }
}

class AllItemsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
      final equippedItems = List.from(state.equippedItems ?? []);
      final items = List.from(state.equipment ?? []);

      return Column(
        children: items.map((e) {
          final isEquipped = equippedItems.remove(e);
          return EquipmentItem(
            equipmentQuantity: e,
            isEquipped: isEquipped,
          );
        }).toList(),
      );
    });
  }
}

class EquipmentItem extends StatelessWidget {
  final EquipmentQuantity equipmentQuantity;
  final bool isEquipped;

  const EquipmentItem({
    Key? key,
    required this.equipmentQuantity,
    required this.isEquipped,
  }) : super(key: key);

  @override
  Widget build(BuildContext rootContext) {
    final equipment = equipmentQuantity.equipment;
    return Row(
      children: [
        equipment.isEquippable
            ? EquipmentSelectionButton(
                equipmentQuantity: equipmentQuantity,
                isEquipped: isEquipped,
              )
            : Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 12,
                  height: 1,
                  color: Color(0xFFDCDAD9),
                ),
              ),
        SizedBox(width: 15),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    equipment.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFFDCDAD9),
                    ),
                  ),
                  Text(
                    equipment.equipmentCategory.getName(rootContext),
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xAADCDAD9),
                    ),
                  )
                ],
              ),
              if (equipmentQuantity.quantity > 1) SizedBox(width: 16),
              if (equipmentQuantity.quantity > 1)
                Text(
                  "(${equipmentQuantity.quantity})",
                  style: TextStyle(
                      fontSize: 20, color: Colors.white.withOpacity(.6)),
                ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              showDialog(
                  context: rootContext,
                  builder: (context) {
                    return SureToDeleteEquipment(context, equipmentQuantity,
                        (equipment) {
                      BlocProvider.of<CharacterBloc>(rootContext)
                          .add(RemoveEquipmentItem(equipment));
                    });
                  });
            },
            icon: Icon(
              Icons.delete,
              color: Color(0xFFFF5251),
            ))
      ],
    );
  }
}

class EquipmentSelectionButton extends StatelessWidget {
  final EquipmentQuantity equipmentQuantity;
  final bool isEquipped;

  const EquipmentSelectionButton({
    Key? key,
    required this.equipmentQuantity,
    required this.isEquipped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final bloc = BlocProvider.of<CharacterBloc>(context);
        if (isEquipped) {
          bloc.add(UnequipItem(equipmentQuantity));
        } else {
          bloc.add(EquipItem(equipmentQuantity));
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFDCDAD9), width: 3),
                borderRadius: BorderRadius.circular(8)),
          ),
          if (isEquipped)
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                  color: Color(0xFFFF5251),
                  borderRadius: BorderRadius.circular(4)),
            ),
        ],
      ),
    );
  }
}

class MoneyItem extends StatelessWidget {
  final String assetUrl;
  final String value;

  const MoneyItem({
    Key? key,
    required this.assetUrl,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(assetUrl),
        SizedBox(width: 4),
        Text(value),
      ],
    );
  }
}
