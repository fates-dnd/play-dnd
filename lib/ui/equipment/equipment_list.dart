import 'package:dnd_player_flutter/bloc/equipment/equipment_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/localization/equipment_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EquipmentList extends StatelessWidget {
  final Function(Equipment) onEquipmentSelected;

  const EquipmentList({Key? key, required this.onEquipmentSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EquipmentBloc(getIt.get<EquipmentRepository>())..add(LoadEquipment()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Снаряжение"),
        ),
        body: BlocBuilder<EquipmentBloc, EquipmentState>(
          builder: (context, state) => ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemCount: state.equipment.length,
              itemBuilder: (context, index) {
                final item = state.equipment[index];
                return EquipmentItem(
                  onSelected: onEquipmentSelected,
                  equipment: item,
                );
              }),
        ),
      ),
    );
  }
}

class EquipmentItem extends StatelessWidget {
  final Function(Equipment) onSelected;
  final Equipment equipment;

  const EquipmentItem({
    Key? key,
    required this.onSelected,
    required this.equipment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.primaryColorLight,
      child: InkWell(
        onTap: () {
          onSelected(equipment);
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              // description
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    equipment.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFE5E1DE),
                    ),
                  ),
                  EquipmentDescriptionRow(
                    equipmentCategory: equipment.equipmentCategory,
                  ),
                ],
              )),

              // damage
              DamageCell(damage: equipment.damage),
            ],
          ),
        ),
      ),
    );
  }
}

class EquipmentDescriptionRow extends StatelessWidget {
  final EquipmentCategory equipmentCategory;

  const EquipmentDescriptionRow({Key? key, required this.equipmentCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          equipmentCategory.getName(),
          style: TextStyle(color: Color(0xAADCDAD9), fontSize: 12),
        ),
        // properties
        // Container(color: Color(0xFFFF5251),),
        // Text(),
      ],
    );
  }
}

class DamageCell extends StatelessWidget {
  final Damage? damage;

  const DamageCell({Key? key, required this.damage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (damage == null) {
      return SizedBox();
    }
    return Text(
      "${damage?.damageDice} ${damage?.damageType.name}",
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFFE5E1DE),
      ),
    );
  }
}
