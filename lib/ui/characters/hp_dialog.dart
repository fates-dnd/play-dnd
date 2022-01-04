import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/bloc/hp_dialog/hp_dialog_bloc.dart';
import 'package:dnd_player_flutter/ui/common/slider_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HpDialog extends StatelessWidget {
  final CharacterBloc characterBloc;

  const HpDialog({
    Key? key,
    required this.characterBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HpDialogBloc(),
      child: AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.health,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
        content: Container(
          decoration: BoxDecoration(
            color: Color(0xFF272E32),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  _MaxHpText(value: characterBloc.state.maxHp),
                  SizedBox(
                    width: 24,
                  ),
                  _CurrentHpText(value: characterBloc.state.hp),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 24),
                  _PointsSelector(),
                  _ActionsGroup(
                    onHeal: (amount) => characterBloc.add(Heal(amount)),
                    onDamage: (amount) => characterBloc.add(Damage(amount)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MaxHpText extends StatelessWidget {
  final int value;

  const _MaxHpText({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _HpText(
      description: AppLocalizations.of(context)!.max_hp,
      value: value,
    );
  }
}

class _CurrentHpText extends StatelessWidget {
  final int value;

  const _CurrentHpText({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _HpText(
      description: AppLocalizations.of(context)!.current_hp,
      value: value,
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

class _ActionsGroup extends StatelessWidget {
  final Function(int) onHeal;
  final Function(int) onDamage;

  const _ActionsGroup({
    Key? key,
    required this.onHeal,
    required this.onDamage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Column(
      children: [
        TextButton(
          onPressed: () {
            final hpDialogAmount =
                BlocProvider.of<HpDialogBloc>(context).state.selectedAmount;
            onHeal(hpDialogAmount);
            Navigator.of(context).pop();
          },
          child: Text(localizations!.heal),
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0),
            minimumSize: Size(120, 40),
            backgroundColor: Color(0xFF3AFFBD),
          ),
        ),
        SizedBox(height: 8),
        TextButton(
          onPressed: () {
            final hpDialogAmount =
                BlocProvider.of<HpDialogBloc>(context).state.selectedAmount;
            onDamage(hpDialogAmount);
            Navigator.of(context).pop();
          },
          child: Text(
            localizations.damage,
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0),
            minimumSize: Size(120, 40),
          ),
        ),
      ],
    );
  }
}

class _PointsSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 142,
      width: 80,
      child: SliderSelector(
        children: List.generate(
            100,
            (index) => BlocBuilder<HpDialogBloc, HpDialogState>(
                  buildWhen: (oldState, newState) =>
                      oldState.selectedAmount == index ||
                      newState.selectedAmount == index,
                  builder: (context, state) {
                    return Text(
                      "$index",
                      style: TextStyle(
                          fontSize: index == state.selectedAmount ? 32 : 24,
                          fontWeight: index == state.selectedAmount
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: index == state.selectedAmount
                              ? Colors.white
                              : Colors.white30),
                    );
                  },
                )),
        onItemChanged: (value) =>
            BlocProvider.of<HpDialogBloc>(context).add(HpDialogEvent(value)),
        itemExtent: 42,
        shrinkWrap: true,
      ),
    );
  }
}
