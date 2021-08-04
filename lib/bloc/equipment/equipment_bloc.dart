import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:meta/meta.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {

  final EquipmentRepository repository;

  EquipmentBloc(this.repository) : super(EquipmentState([]));

  @override
  Stream<EquipmentState> mapEventToState(
    EquipmentEvent event,
  ) async* {
    if (event is LoadEquipment) {
      final equipment = await repository.getEquipment();
      yield EquipmentState(equipment);
    }
  }
}
