import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/bloc/character/unarmed_attack.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/ui/equipment/equipment_list.dart';
import 'package:dnd_player_flutter/ui/equipment/sure_to_delete_equipment.dart';
import 'package:dnd_player_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EquipmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (rootContext, state) => ListView(
        children: [
          EquippedSection(),
          SizedBox(height: 12),
          MoneyInfoRow(),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EquipmentList(
                      onEquipmentSelected: (item) {
                        BlocProvider.of<CharacterBloc>(rootContext)
                            .add(AddEquipmentItem(item));
                      },
                    );
                  }));
                },
                child: Text("Добавить"),
              ),
            ],
          ),
          SizedBox(height: 14),
          for (var i = 0; i < (state.equipment?.length ?? 0); ++i)
            EquipmentItem(equipment: state.equipment![i])
        ],
      ),
    );
  }
}

class EquippedSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              "Екипировка",
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
                      "Урон",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFDCDAD9),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            for (var i = 0; i < (state.equippedItems?.length ?? 0); ++i)
              EquippedItem(equipment: state.equippedItems![i]),
            UnarmedAttackRow(
              unarmedAttack: state.unarmedAttack,
            ),
          ],
        ),
      ),
    );
  }
}

class EquippedItem extends StatelessWidget {
  final Equipment equipment;

  const EquippedItem({Key? key, required this.equipment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

          Expanded(
              flex: 1,
              child:
                  Center(child: ActionableInfo(content: "+4"))), // attack roll
          Expanded(
              flex: 1,
              child: Center(
                  child: ActionableInfo(content: "1d4+2"))), // damage roll
        ],
      ),
    );
  }
}

class UnarmedAttackRow extends StatelessWidget {
  final UnarmedAttack unarmedAttack;

  const UnarmedAttackRow({Key? key, required this.unarmedAttack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  "Безоружная атака",
                  style: TextStyle(
                    color: Color(0xDDDCDAD9),
                    fontSize: 18,
                  ),
                ), // name
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Ближний бой",
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

class EquipmentItem extends StatelessWidget {
  final Equipment equipment;

  const EquipmentItem({Key? key, required this.equipment}) : super(key: key);

  @override
  Widget build(BuildContext rootContext) {
    return Row(
      children: [
        equipment.isEquippable
            ? EquipmentSelectionButton(equipment: equipment, isEquipped: false)
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
          child: Column(
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
        ),
        IconButton(
            onPressed: () {
              showDialog(
                  context: rootContext,
                  builder: (context) {
                    return SureToDeleteEquipment(context, equipment,
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
  final Equipment equipment;
  final bool isEquipped;

  const EquipmentSelectionButton({
    Key? key,
    required this.equipment,
    required this.isEquipped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) => InkWell(
        onTap: () {
          final bloc = BlocProvider.of<CharacterBloc>(context);
          if (state.isEquipped(equipment)) {
            bloc.add(UnequipItem(equipment));
          } else {
            bloc.add(EquipItem(equipment));
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
            if (state.isEquipped(equipment))
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                    color: Color(0xFFFF5251),
                    borderRadius: BorderRadius.circular(4)),
              ),
          ],
        ),
      ),
    );
  }
}

class MoneyInfoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {},
          child: Text("Деньги"),
        ),
        SizedBox(width: 12),
        MoneyItem(assetUrl: "assets/drawable/money/platinum.png", value: "0"),
        SizedBox(width: 12),
        MoneyItem(assetUrl: "assets/drawable/money/gold.png", value: "0"),
        SizedBox(width: 12),
        MoneyItem(assetUrl: "assets/drawable/money/electrum.png", value: "0"),
        SizedBox(width: 12),
        MoneyItem(assetUrl: "assets/drawable/money/silver.png", value: "0"),
        SizedBox(width: 12),
        MoneyItem(assetUrl: "assets/drawable/money/bronze.png", value: "0"),
      ],
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
