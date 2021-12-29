import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RestDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return AlertDialog(
      content: Container(
        height: 232,
        decoration: BoxDecoration(
          color: Color(0xFF272E32),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              localizations!.rest,
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text(
                localizations.short_rest,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32)),
            ),
            SizedBox(height: 24),
            TextButton(
              onPressed: () {},
              child: Text(
                localizations.long_rest,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32)),
            ),
          ],
        ),
      ),
    );
  }
}
