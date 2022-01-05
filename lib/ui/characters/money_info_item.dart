import 'package:dnd_player_flutter/dto/currency.dart';
import 'package:dnd_player_flutter/utils.dart';
import 'package:flutter/material.dart';

class MoneyInfoItem extends StatelessWidget {
  final Currency currency;
  final int value;
  final double? fontSize;

  const MoneyInfoItem({
    Key? key,
    required this.currency,
    required this.value,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          currency.toAssetPath(),
        ),
        SizedBox(width: 4),
        Text(
          value.toString(),
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        )
      ],
    );
  }
}
