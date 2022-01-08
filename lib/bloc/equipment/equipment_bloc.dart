import 'package:bloc/bloc.dart';
import 'package:dnd_player_flutter/dto/equipment.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:meta/meta.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  final SettingsRepository settingsRepository;
  final EquipmentRepository repository;

  EquipmentBloc(this.settingsRepository, this.repository)
      : super(EquipmentState([])) {
    on<EquipmentEvent>((event, emit) async {
      final language = await settingsRepository.getLanguage();
      if (event is LoadEquipment) {
        final equipment = await repository.getEquipment(language);
        emit.call(EquipmentState(equipment));
      } else if (event is SearchValueChanged) {
        final equipment = await repository.getEquipment(language);
        final searchValue = event.searchValue.toLowerCase();
        emit.call(EquipmentState(equipment
            .where((element) =>
                element.index.toLowerCase().contains(searchValue) ||
                element.name.toLowerCase().contains(searchValue))
            .toList()));
      } else if (event is SearchCancelled) {
        final equipment = await repository.getEquipment(language);
        emit.call(EquipmentState(equipment));
      }
    });
  }
}
