import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/dto/trait.dart';
import 'package:dnd_player_flutter/dto/user_feature.dart';
import 'package:dnd_player_flutter/ui/traits_and_features/manage_feature_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TraitsAndFeaturesPage extends StatelessWidget {
  const TraitsAndFeaturesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        return ListView(
          children: []
            ..add(SectionTitle(title: localizations.class_features))
            ..add(ManageButton())
            ..addAll(state.userFeatures?.map((feature) => FeatureAndTraitItem(
                      feature: feature,
                    )) ??
                [])
            ..add(SectionTitle(title: localizations.racial_traits))
            ..addAll(state.traits?.map((trait) => FeatureAndTraitItem(
                      trait: trait,
                    )) ??
                []),
        );
      },
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

class ManageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ManageFeatureScreen();
        }));
      },
      child: Text(localizations.add),
    );
  }
}

class FeatureAndTraitItem extends StatelessWidget {
  final UserFeature? feature;
  final Trait? trait;

  const FeatureAndTraitItem({
    Key? key,
    this.feature,
    this.trait,
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
  final UserFeature feature;

  const FeatureItem({
    Key? key,
    required this.feature,
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
            // if (feature.levels != null && feature.expandable == false)
            //   Text(
            //     "(${feature.getNonExpandableNameForLevel(level)})",
            //     style: TextStyle(fontSize: 18),
            //   )
          ],
        ),
        SizedBox(height: 8),
        Text(
          feature.description,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
        if ((feature.usage?.maxUsages ?? 0) > 0)
          SelectionRows(
            feature: feature,
            count: feature.usage?.maxUsages ?? 0,
          ),
      ],
    );
  }
}

class SelectionRows extends StatelessWidget {
  final UserFeature feature;
  final int count;

  const SelectionRows({Key? key, required this.feature, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
      final itemsPerRow = 8;
      final usedSlots = feature.usage?.usages ?? 0;

      var rows = count ~/ itemsPerRow;
      final lastRowItems = count - (rows * itemsPerRow);
      if (count > (rows * itemsPerRow)) {
        rows += 1;
      }

      return Column(
        children: List.generate(
            rows,
            (row) => Row(
                children: List.generate(
                    row == rows - 1 ? lastRowItems : itemsPerRow,
                    (index) => Padding(
                          padding: const EdgeInsets.only(right: 8, bottom: 8),
                          child: SelectionItem(
                            feature: feature,
                            isUsed: index < usedSlots,
                          ),
                        )))),
      );
    });
  }
}

class SelectionItem extends StatelessWidget {
  final UserFeature feature;
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
        onTap: () {},
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
