import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatCalculatorScreen extends StatelessWidget {
  final CharacteristicBonus characteristicBonus;

  const StatCalculatorScreen({
    Key? key,
    required this.characteristicBonus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(characteristicBonus.characteristic.getName(context)),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            _NumpadRow(values: ["1", "2", "3"]),
            _NumpadRow(values: ["4", "5", "6"]),
            _NumpadRow(values: ["7", "8", "9"]),
            _LastRow(),
          ],
        ));
  }
}

class _NumpadRow extends StatelessWidget {
  final List<String> values;

  const _NumpadRow({Key? key, required this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: values
          .map((value) => Expanded(child: _NumpadButton(value: value)))
          .toList(),
    );
  }
}

class _LastRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: _NumpadButton(value: "0")),
        Flexible(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

class _NumpadButton extends StatelessWidget {
  final String value;

  const _NumpadButton({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Ink(
          decoration: BoxDecoration(
            color: Color(0xFF272E32),
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {},
            child: Center(
              child: Text(
                value,
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
