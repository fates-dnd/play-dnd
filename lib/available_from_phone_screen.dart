import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AvailableFromPhoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_android,
              color: Colors.white54,
              size: 60,
            ),
            SizedBox(height: 16),
            Text(
              localizations.use_your_phone,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 32),
            ),
          ],
        ),
      ),
    );
  }
}
