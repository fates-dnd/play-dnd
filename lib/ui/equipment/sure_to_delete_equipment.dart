import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:flutter/material.dart';

class SureToDeleteEquipment extends AlertDialog {
  final BuildContext callerContext;
  final EquipmentQuantity equipmentQuantity;
  final Function(EquipmentQuantity) onDeleteEquipment;

  SureToDeleteEquipment(
      this.callerContext, this.equipmentQuantity, this.onDeleteEquipment)
      : super(
            title:
                Text("Точно удалить \"${equipmentQuantity.equipment.name}\"?"),
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
                  onDeleteEquipment(equipmentQuantity);
                  Navigator.of(callerContext).pop();
                },
              )
              // no
            ]);
}
