part of 'manage_traits_and_features_bloc.dart';

abstract class ManageTraitsAndFeaturesEvent {}

class OnNameChanged extends ManageTraitsAndFeaturesEvent {
  final String name;

  OnNameChanged(this.name);
}

class OnDescriptionChanged extends ManageTraitsAndFeaturesEvent {
  final String description;

  OnDescriptionChanged(this.description);
}

class OnUsagesChanged extends ManageTraitsAndFeaturesEvent {
  final int? usages;

  OnUsagesChanged(this.usages);
}

class OnResetsOnChanged extends ManageTraitsAndFeaturesEvent {
  final Rest? resetsOn;

  OnResetsOnChanged(this.resetsOn);
}
