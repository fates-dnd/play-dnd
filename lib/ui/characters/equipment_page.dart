import 'package:dnd_player_flutter/ui/equipment_list.dart';
import 'package:flutter/material.dart';

class EquipmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        EquippedSection(),
        SizedBox(height: 12),
        MoneyInfoRow(),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          OutlinedButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return EquipmentList();
            }));
          }, child: Text("Добавить")),
        ],),
      ],
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
