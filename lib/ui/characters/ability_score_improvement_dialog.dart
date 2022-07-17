import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AbilityScoreImprovementDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(localization.ability_score_improvement),
    );
  }
}
