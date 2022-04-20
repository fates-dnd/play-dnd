import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/bloc/traits_and_features/traits_and_features_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/class.dart';
import 'package:dnd_player_flutter/dto/feature.dart';
import 'package:dnd_player_flutter/dto/race.dart';
import 'package:dnd_player_flutter/dto/trait.dart';
import 'package:dnd_player_flutter/repository/features_repository.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/traits_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localizations = AppLocalizations.of(context)!;
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
              ..add(SectionTitle(title: localizations.racial_traits))
              ..addAll(state.traits.map((trait) => FeatureAndTraitItem(
                    trait: trait,
                    level: level,
                  )))
              ..add(SectionTitle(title: localizations.class_features))
              ..addAll(state.features.map((feature) => FeatureAndTraitItem(
                    feature: feature,
                    level: level,
                  ))),
          );
        },
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class FeatureAndTraitItem extends StatelessWidget {
  final Feature? feature;
  final Trait? trait;
  final int level;

  const FeatureAndTraitItem({
    Key? key,
    this.feature,
    this.trait,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: theme.primaryColorLight,
        ),
        padding: const EdgeInsets.all(16),
        child: _getChild(),
      ),
    );
  }

  Widget _getChild() {
    if (feature != null) {
      return FeatureItem(
        feature: feature!,
        level: level,
      );
    }
    if (trait != null) {
      return TraitItem(trait: trait!);
    }

    return SizedBox();
  }
}

class TraitItem extends StatelessWidget {
  final Trait trait;

  const TraitItem({Key? key, required this.trait}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          trait.name,
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 8),
        Text(
          trait.description.join("\n"),
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

class FeatureItem extends StatelessWidget {
  final Feature feature;
  final int level;

  const FeatureItem({
    Key? key,
    required this.feature,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              feature.name,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 8),
            if (feature.levels != null && feature.expandable == false)
              Text(
                "(${feature.getNonExpandableNameForLevel(level)})",
                style: TextStyle(fontSize: 18),
              )
          ],
        ),
        SizedBox(height: 8),
        Text(
          feature.description.join("\n"),
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
        SelectionRows(
          feature: feature,
          count: feature.getExpandableCountForLevel(level) ?? 0,
        ),
      ],
    );
  }
}

class SelectionRows extends StatelessWidget {
  final Feature feature;
  final int count;

  const SelectionRows({Key? key, required this.feature, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
      final usedSlots = state.featureUsage?[feature.index] ?? 0;
      return Row(
        children: List.generate(
            count,
            (index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SelectionItem(
                    feature: feature,
                    isUsed: index < usedSlots,
                  ),
                )),
      );
    });
  }
}

class SelectionItem extends StatelessWidget {
  final Feature feature;
  final bool isUsed;

  const SelectionItem({
    Key? key,
    required this.feature,
    required this.isUsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Color(0xFFDCDAD9),
        ),
      ),
      child: InkWell(
        onTap: () {
          BlocProvider.of<CharacterBloc>(context).add(
              isUsed ? DecrementFeature(feature) : IncrementFeature(feature));
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: isUsed
              ? Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color(0xFFFF5251),
                ))
              : SizedBox(),
        ),
      ),
    );
  }
}
