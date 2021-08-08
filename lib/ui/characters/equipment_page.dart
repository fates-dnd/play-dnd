import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/ui/equipment_list.dart';
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
    );
  }
}

class EquipmentItem extends StatelessWidget {
  final Equipment equipment;

  const EquipmentItem({Key? key, required this.equipment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
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
                equipment.equipmentCategory.name,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xAADCDAD9),
                ),
              )
            ],
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete,
              color: Color(0xFFFF5251),
            ))
      ],
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
