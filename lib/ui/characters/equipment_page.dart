import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/ui/equipment/equipment_list.dart';
import 'package:dnd_player_flutter/ui/equipment/sure_to_delete_equipment.dart';
import 'package:dnd_player_flutter/localization/equipment_category_locale.dart';
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
                  child: Text("Добавить")),
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
    return Container(
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
          )
        ],
      ),
    );
  }
}

class EquippedItem extends StatelessWidget {
  
  final Equipment equipment;

  const EquippedItem({Key? key, required this.equipment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(equipment.name), // name
            // weapon range
          ],
        ),

        Text("+4"), // attack roll
        Text("1d4+2"), // damage roll
      ],
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
          : Container(
            width: 12,
            height: 1,
            color: Color(0xFFDCDAD9),
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
                equipment.equipmentCategory.getName(),
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
              showDialog(context: rootContext, builder: (context) {
                return SureToDeleteEquipment(context, equipment, (equipment) {
                  BlocProvider.of<CharacterBloc>(rootContext).add(RemoveEquipmentItem(equipment));
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
        onTap: () {},
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFDCDAD9),
                  width: 3
                ),
                borderRadius: BorderRadius.circular(8)
              ),
            ),
            if (state.isEquipped(equipment))
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF5251),
                    borderRadius: BorderRadius.circular(4)
                  ),
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
        MoneyItem(assetUrl: "assets/money/platinum.png", value: "0"),
        SizedBox(width: 12),
        MoneyItem(assetUrl: "assets/money/gold.png", value: "0"),
        SizedBox(width: 12),
        MoneyItem(assetUrl: "assets/money/electrum.png", value: "0"),
        SizedBox(width: 12),
        MoneyItem(assetUrl: "assets/money/silver.png", value: "0"),
        SizedBox(width: 12),
        MoneyItem(assetUrl: "assets/money/bronze.png", value: "0"),
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
