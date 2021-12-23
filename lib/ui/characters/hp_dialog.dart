import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        constraints: BoxConstraints(maxHeight: 300),
        decoration: BoxDecoration(
          color: Color(0xFF272E32),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.health,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                _MaxHpText(),
                SizedBox(
                  width: 24,
                ),
                _CurrentHpText(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MaxHpText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
      return _HpText(
        description: AppLocalizations.of(context)!.max_hp,
        value: state.maxHp,
      );
    });
  }
}

class _CurrentHpText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        return _HpText(
          description: AppLocalizations.of(context)!.current_hp,
          value: state.hp,
        );
      },
    );
  }
}

class _HpText extends StatelessWidget {
  final String description;
  final int value;

  const _HpText({
    Key? key,
    required this.description,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      children: [
        TextSpan(
            text: "$description: ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            )),
        TextSpan(
            text: value.toString(),
            style: TextStyle(
              color: Color(0xFFFF5251),
              fontSize: 18,
            )),
      ],
    ));
  }
}
