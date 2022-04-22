part of 'traits_and_features_bloc.dart';

abstract class TraitsAndFeaturesEvent {}

class LoadTraitsAndFeatures extends TraitsAndFeaturesEvent {
  final Race race;
  final Class clazz;
  final int level;

  LoadTraitsAndFeatures(
    this.race,
    this.clazz,
    this.level,
  );
}
