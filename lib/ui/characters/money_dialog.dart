import 'package:dnd_player_flutter/bloc/money_dialog/money_dialog_bloc.dart';
import 'package:dnd_player_flutter/dto/currency.dart';
import 'package:dnd_player_flutter/ui/common/slider_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoneyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => MoneyDialogBloc(),
      child: AlertDialog(
        title: Text(
          localizations!.money,
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
          ),
        ),
        content: Container(
          height: 160,
          child: Column(
            children: [
              _AmountCurrencyRow(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AmountCurrencyRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) => BlocProvider.of<MoneyDialogBloc>(context)
                .add(ChangeMoneyValue(int.parse(value))),
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 24,
        ),
        Flexible(
          flex: 1,
          child: SizedBox(
            height: 142,
            width: 140,
            child: SliderSelector(
              itemExtent: 48,
              onItemChanged: (position) {
                final bloc = BlocProvider.of<MoneyDialogBloc>(context);
                switch (position) {
                  case 0:
                    bloc.add(ChangeCurrency(Currency.COPPER));
                    break;
                  case 1:
                    bloc.add(ChangeCurrency(Currency.SILVER));
                    break;
                  case 2:
                    bloc.add(ChangeCurrency(Currency.ELECTRUM));
                    break;
                  case 3:
                    bloc.add(ChangeCurrency(Currency.GOLD));
                    break;
                  case 4:
                    bloc.add(ChangeCurrency(Currency.PLATINUM));
                    break;
                }
              },
              children: [
                _RowMoneyOption(
                  currency: Currency.COPPER,
                  assetIcon: "assets/drawable/money/copper.png",
                  title: localizations!.copper,
                ),
                _RowMoneyOption(
                  currency: Currency.SILVER,
                  assetIcon: "assets/drawable/money/silver.png",
                  title: localizations.silver,
                ),
                _RowMoneyOption(
                  currency: Currency.ELECTRUM,
                  assetIcon: "assets/drawable/money/electrum.png",
                  title: localizations.electrum,
                ),
                _RowMoneyOption(
                  currency: Currency.GOLD,
                  assetIcon: "assets/drawable/money/gold.png",
                  title: localizations.gold,
                ),
                _RowMoneyOption(
                  currency: Currency.PLATINUM,
                  assetIcon: "assets/drawable/money/platinum.png",
                  title: localizations.platinum,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _RowMoneyOption extends StatelessWidget {
  final Currency currency;
  final String assetIcon;
  final String title;

  const _RowMoneyOption({
    Key? key,
    required this.currency,
    required this.assetIcon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoneyDialogBloc, MoneyDialogState>(
      buildWhen: (oldState, newState) =>
          oldState.selectedCurrency == currency ||
          newState.selectedCurrency == currency,
      builder: (context, state) {
        final isSelected = state.selectedCurrency == currency;
        return Opacity(
          opacity: isSelected ? 1.0 : 0.5,
          child: Row(
            children: [
              SizedBox(
                width: 24,
                child: Image.asset(assetIcon),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
