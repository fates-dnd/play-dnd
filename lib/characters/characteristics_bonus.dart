import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:flutter/material.dart';

class CharacteristicsBonus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Бонус характеристик"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _createCharacteristicsSelect(
                context, "Характеристика 1", (value) {}),
            SizedBox(height: 12),
            _createCharacteristicsSelect(
                context, "Характеристика 2", (value) {}),
          ],
        ),
      ),
    );
  }

  DropdownButton _createCharacteristicsSelect(
      BuildContext context, String hint, ValueChanged<String?>? onChanged) {
    final theme = Theme.of(context);
    return DropdownButton(
      hint: Text(
        hint,
        style: TextStyle(color: Color(0xffa4a4a4)),
      ),
      underline: Container(height: 2, color: theme.accentColor),
      dropdownColor: theme.primaryColorLight,
      icon: Icon(Icons.arrow_drop_down),
      items: <Characteristic>[
        Strength(),
        Dexterity(),
        Constitution(),
        Intellect(),
        Wisdom(),
        Charisma()
      ]
          .map((e) =>
              DropdownMenuItem<Characteristic>(value: e, child: Text(e.name)))
          .toList(),
      onChanged: (value) {},
    );
  }
}
