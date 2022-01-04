import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/bloc/money_dialog/money_dialog_bloc.dart';
import 'package:dnd_player_flutter/dto/currency.dart';
import 'package:dnd_player_flutter/ui/common/slider_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoneyDialog extends StatelessWidget {
  final CharacterBloc characterBloc;

  const MoneyDialog({Key? key, required this.characterBloc}) : super(key: key);

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MoneyInfo(money: characterBloc.state.money),
              SizedBox(height: 16),
              _AmountCurrencyRow(),
              SizedBox(height: 32),
              _ActionRow(characterBloc: characterBloc),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoneyInfo extends StatelessWidget {
  final Map<Currency, int>? money;

  const _MoneyInfo({Key? key, required this.money}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      runSpacing: 8,
      spacing: 16,
      children: money?.entries
              .map(
                (entry) => _MoneyInfoItem(
                  currency: entry.key,
                  value: entry.value,
                ),
              )
              .toList() ??
          [],
    );
  }
}

class _MoneyInfoItem extends StatelessWidget {
  final Currency currency;
  final int value;

  const _MoneyInfoItem({
    Key? key,
    required this.currency,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          _currencyToAssetPath(currency),
        ),
        SizedBox(width: 4),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            value.toString(),
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
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
            decoration: InputDecoration(
              hintText: "0",
              hintStyle: TextStyle(fontSize: 32, color: Colors.white30),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => BlocProvider.of<MoneyDialogBloc>(context)
                .add(ChangeMoneyValue(int.tryParse(value) ?? 0)),
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
          flex: 2,
          child: SizedBox(
            height: 142,
            width: 140,
            child: SliderSelector(
              itemExtent: 48,
              totalHeight: 142,
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
                  title: localizations!.copper,
                ),
                _RowMoneyOption(
                  currency: Currency.SILVER,
                  title: localizations.silver,
                ),
                _RowMoneyOption(
                  currency: Currency.ELECTRUM,
                  title: localizations.electrum,
                ),
                _RowMoneyOption(
                  currency: Currency.GOLD,
                  title: localizations.gold,
                ),
                _RowMoneyOption(
                  currency: Currency.PLATINUM,
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
  final String title;

  const _RowMoneyOption({
    Key? key,
    required this.currency,
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
                child: Image.asset(_currencyToAssetPath(currency)),
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

class _ActionRow extends StatelessWidget {
  final CharacterBloc characterBloc;

  const _ActionRow({Key? key, required this.characterBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: TextButton(
            onPressed: () {
              final moneyState =
                  BlocProvider.of<MoneyDialogBloc>(context).state;
              characterBloc.add(EarnMoney(
                  moneyState.selectedCurrency, moneyState.selectedValue));
              Navigator.of(context).pop();
            },
            child: Text(localizations!.earn),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              backgroundColor: Color(0xFF3AFFBD),
            ),
          ),
        ),
        SizedBox(width: 16),
        Flexible(
          flex: 1,
          child: TextButton(
            onPressed: () {
              final moneyState =
                  BlocProvider.of<MoneyDialogBloc>(context).state;
              characterBloc.add(SpendMoney(
                  moneyState.selectedCurrency, moneyState.selectedValue));
              Navigator.of(context).pop();
            },
            child: Text(
              localizations.spend,
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }
}

String _currencyToAssetPath(Currency currency) {
  switch (currency) {
    case Currency.COPPER:
      return "assets/drawable/money/copper.png";
    case Currency.SILVER:
      return "assets/drawable/money/silver.png";
    case Currency.ELECTRUM:
      return "assets/drawable/money/electrum.png";
    case Currency.GOLD:
      return "assets/drawable/money/gold.png";
    case Currency.PLATINUM:
      return "assets/drawable/money/platinum.png";
  }
}
