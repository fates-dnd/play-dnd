import 'package:dnd_player_flutter/bloc/traits_and_features/traits_and_features_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/feature.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/trait.dart';
import 'package:dnd_player_flutter/repository/features_repository.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/traits_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TraitsAndFeaturesPage extends StatelessWidget {
  final Race race;
  final Class clazz;
  final int level;

  const TraitsAndFeaturesPage({
    Key? key,
    required this.race,
    required this.clazz,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TraitsAndFeaturesBloc(
        getIt<SettingsRepository>(),
        getIt<TraitsRepository>(),
        getIt<FeaturesRepository>(),
      )..add(LoadTraitsAndFeatures(
          race,
          clazz,
          level,
        )),
      child: BlocBuilder<TraitsAndFeaturesBloc, TraitsAndFeaturesState>(
        builder: (context, state) {
          return ListView(
            children: []
              ..addAll(state.traits.map((trait) => TraitItem(trait: trait)))
              ..addAll(state.features
                  .map((feature) => FeatureItem(feature: feature))),
          );
        },
      ),
    );
  }
}

class TraitItem extends StatelessWidget {
  final Trait trait;

  const TraitItem({Key? key, required this.trait}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(trait.name),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final Feature feature;

  const FeatureItem({Key? key, required this.feature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(feature.name),
    );
  }
}
