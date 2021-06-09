import 'package:dnd_player_flutter/repository/json_asset_loader.dart';
import 'package:dnd_player_flutter/repository/races_repository.dart';
import 'package:dnd_player_flutter/repository/traits_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void registerDependencies() {  
  getIt.registerSingleton<RacesRepository>(RacesRepository(readRacesJson));
  getIt.registerSingleton<TraitsRepository>(TraitsRepository(readTraitsJson));
}