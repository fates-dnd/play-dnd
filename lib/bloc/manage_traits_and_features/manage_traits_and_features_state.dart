part of 'manage_traits_and_features_bloc.dart';

class ManageTraitsAndFeaturesState {
  final String? name;
  final String? description;
  final int? usages;
  final Rest? resetsOn;

  bool get isSaveable => name != null && description != null;

  ManageTraitsAndFeaturesState({
    this.name,
    this.description,
    this.usages,
    this.resetsOn,
  });

  ManageTraitsAndFeaturesState updateNameOrDescription({
    String? name,
    String? description,
  }) {
    return ManageTraitsAndFeaturesState(
      name: name ?? this.name,
      description: description ?? this.description,
      usages: this.usages,
      resetsOn: this.resetsOn,
    );
  }

  ManageTraitsAndFeaturesState updateUsages(
    int? usages,
  ) {
    return ManageTraitsAndFeaturesState(
      name: this.name,
      description: this.description,
      usages: usages,
      resetsOn: this.resetsOn,
    );
  }

  ManageTraitsAndFeaturesState updateResetsOn(
    Rest? resetOn,
  ) {
    return ManageTraitsAndFeaturesState(
      name: this.name,
      description: this.description,
      usages: this.usages,
      resetsOn: resetsOn,
    );
  }
}
