import 'package:dnd_player_flutter/bloc/stat_calulator/stat_calculator_bloc.dart';
import 'package:dnd_player_flutter/data/characteristics.dart';
import 'package:dnd_player_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatCalculatorScreen extends StatelessWidget {
  final CharacteristicBonus characteristicBonus;
  final Function(int) onSubmit;

  const StatCalculatorScreen({
    Key? key,
    required this.characteristicBonus,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatCalculatorBloc(
        StatCalculatorState(
          0,
          characteristicBonus.bonus,
          characteristicBonus.bonus,
          StatCalculatorError.NONE,
        ),
      ),
      child: Scaffold(
          appBar: AppBar(
            title: Text(characteristicBonus.characteristic.getName(context)),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: _Display()),
                      _ErrorLine(),
                    ],
                  ),
                ),
                _NumpadRow(values: ["1", "2", "3"]),
                _NumpadRow(values: ["4", "5", "6"]),
                _NumpadRow(
                  values: ["7", "8", "9"],
                  action: _BackspaceButton(),
                ),
                _LastRow(
                  onSubmit: onSubmit,
                ),
              ],
            ),
          )),
    );
  }
}

class _Display extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatCalculatorBloc, StatCalculatorState>(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.enteredValue.toString(),
            style: TextStyle(fontSize: 52),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            state.bonus.toBonusString(),
            style:
                TextStyle(fontSize: 46, color: Colors.white.withOpacity(0.5)),
          ),
          SizedBox(width: 12),
          Text(
            "=",
            style: TextStyle(color: Colors.white, fontSize: 64),
          ),
          SizedBox(width: 12),
          Text(
            state.result.toString(),
            style: TextStyle(
              color: Color(0xFFFF5251),
              fontSize: 64,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatCalculatorBloc, StatCalculatorState>(
      builder: (context, state) {
        final appLocalizations = AppLocalizations.of(context)!;
        var errorMessage = "";
        switch (state.error) {
          case StatCalculatorError.MINIMUM_VALUE_IS_3:
            errorMessage = appLocalizations.minimum_value_is_3;
            break;
          case StatCalculatorError.MAXIMUM_VALUE_IS_18:
            errorMessage = appLocalizations.maximum_value_is_18;
            break;
          case StatCalculatorError.NONE:
            errorMessage = "";
            break;
        }

        return Text(
          errorMessage,
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
          ),
        );
      },
    );
  }
}

class _NumpadRow extends StatelessWidget {
  final List<String> values;
  final Widget? action;

  const _NumpadRow({
    Key? key,
    required this.values,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: values
          .map((value) => Expanded(child: _NumpadButton(value: value)))
          .toList()
        ..add(Expanded(child: action ?? SizedBox())),
    );
  }
}

class _LastRow extends StatelessWidget {
  final Function(int) onSubmit;

  const _LastRow({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: _NumpadButton(value: "0")),
        Flexible(
            flex: 3,
            child: AspectRatio(
              aspectRatio: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<StatCalculatorBloc, StatCalculatorState>(
                  builder: (context, state) => TextButton(
                    onPressed: () {
                      onSubmit(state.enteredValue);
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.save,
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

class _NumpadButton extends StatelessWidget {
  final String value;

  const _NumpadButton({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Ink(
          decoration: BoxDecoration(
            color: Color(0xFF272E32),
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              BlocProvider.of<StatCalculatorBloc>(context)
                  .add(ApplyNumber(int.parse(value)));
            },
            child: Center(
              child: Text(
                value,
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BackspaceButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Ink(
          decoration: BoxDecoration(
            color: Color(0xFFFF5251),
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () {
              BlocProvider.of<StatCalculatorBloc>(context).add(Backspace());
            },
            child: Icon(
              Icons.backspace,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
