import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:flutter/material.dart';

class SureToDeleteEquipment extends AlertDialog {

  final BuildContext callerContext;
  final Equipment equipment;
  final Function(Equipment) onDeleteEquipment;

  SureToDeleteEquipment(this.callerContext, this.equipment, this.onDeleteEquipment): super(
    title: Text("Точно удалить \"${equipment.name}\"?"),
    actions: [
        TextButton(
          child: Text("Нет"),
          onPressed: () {
            Navigator.of(callerContext).pop();
          },
        ),
        TextButton(
          child: Text("Да"),
          onPressed: () {
            onDeleteEquipment(equipment);
            Navigator.of(callerContext).pop();
          },
        )
        // no
    ]
  );
}