import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/dto/currency.dart';
import 'package:dnd_player_flutter/ui/characters/abilities_page.dart';
import 'package:dnd_player_flutter/ui/characters/base_characteristics_page.dart';
import 'package:dnd_player_flutter/ui/characters/equipment_page.dart';
import 'package:dnd_player_flutter/ui/characters/hp_dialog.dart';
import 'package:dnd_player_flutter/ui/characters/level_up_dialog.dart';
import 'package:dnd_player_flutter/ui/characters/money_dialog.dart';
import 'package:dnd_player_flutter/ui/characters/money_info_item.dart';
import 'package:dnd_player_flutter/ui/characters/pager_with_indicators.dart';
import 'package:dnd_player_flutter/ui/characters/rest_dialog.dart';
import 'package:dnd_player_flutter/ui/characters/spells_page.dart';
import 'package:dnd_player_flutter/ui/characters/traits_and_features_page.dart';
import 'package:dnd_player_flutter/ui/manage_character/manage_character_screen.dart';
import 'package:dnd_player_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: _CharacterScreenHeader(),
              ),
              SliverToBoxAdapter(
                child: _CharacterActionsRow(),
              ),
            ];
          },
          body: Pages(),
        ),
      ),
    );
  }
}

class _CharacterScreenHeader extends StatelessWidget {
  const _CharacterScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) => Container(
        color: Color(0xFFE5E1DE),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${state.race?.name} ${state.clazz?.name}, ${state.level}",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ManageCharacterScreen()));
                    },
                    icon: Icon(Icons.edit))
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _InitiativeIcon(),
                    ],
                  ),
                ),
                _ArmorClass(),
                SizedBox(width: 12),
                _ProficiencyBonusInfo(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _InitiativeIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.primaryColorLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.asset("assets/drawable/stats/sword.png"),
            SizedBox(width: 8),
            BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) => Text(
                state.initiative.toBonusString(),
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFDCDAD9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArmorClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) => _NotActionInfo(
        assetUrl: "assets/drawable/stats/shield.png",
        value: state.armorClass.toString(),
        color: Color(0xFFADADAD),
      ),
    );
  }
}

class _ProficiencyBonusInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) => _NotActionInfo(
          assetUrl: "assets/drawable/stats/hammer.png",
          value: state.proficiencyBonus.toBonusString(),
          color: Color(0xFFFB9538)),
    );
  }
}

class _NotActionInfo extends StatelessWidget {
  final String assetUrl;
  final String value;
  final Color color;

  const _NotActionInfo({
    Key? key,
    required this.assetUrl,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color, width: 3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetUrl),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _CharacterActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 48,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _HealthButtonIcon(),
            _RestButtonIcon(),
            _MoneyButtonIcon(),
            _LevelUpButtonIcon(),
          ],
        ),
      ),
    );
  }
}

class _HealthButtonIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final characterBloc = BlocProvider.of<CharacterBloc>(context);
    return BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
      return _CharacterRowButton(
        imageAsset: "assets/drawable/stats/heart.png",
        text: "${state.hp} / ${state.maxHp}",
        textColor: Color(0xFFFF5251),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => HpDialog(characterBloc: characterBloc));
        },
      );
    });
  }
}

class _RestButtonIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _CharacterRowButton(
      imageAsset: "assets/drawable/stats/tent.png",
      text: AppLocalizations.of(context)!.rest,
      textColor: Color(0xFF7C7BFC),
      onTap: () {
        showDialog(context: context, builder: (context) => RestDialog());
      },
    );
  }
}

class _MoneyButtonIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final characterBloc = BlocProvider.of<CharacterBloc>(context);
    final action = () {
      showDialog(
          context: context,
          builder: (context) => MoneyDialog(
                characterBloc: characterBloc,
              ));
    };
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        return state.hasMoney
            ? _DetailedMoneyInfo(
                money: state.money,
                onTap: action,
              )
            : _CharacterRowButton(
                imageAsset: "assets/drawable/stats/money.png",
                text: AppLocalizations.of(context)!.money,
                textColor: Color(0xFFE5DD1C),
                onTap: action,
              );
      },
    );
  }
}

class _DetailedMoneyInfo extends StatelessWidget {
  final Map<Currency, int>? money;
  final Function() onTap;

  const _DetailedMoneyInfo({
    Key? key,
    required this.money,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 8),
      child: Ink(
        height: 42,
        decoration: BoxDecoration(
          color: theme.primaryColorLight,
          borderRadius: BorderRadius.circular(24),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: money?.entries
                      .where((element) => element.value != 0)
                      .map((element) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: MoneyInfoItem(
                              currency: element.key,
                              value: element.value,
                              fontSize: 20,
                            ),
                          ))
                      .toList() ??
                  [],
            ),
          ),
        ),
      ),
    );
  }
}

class _LevelUpButtonIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _CharacterRowButton(
      imageAsset: "assets/drawable/stats/xp.png",
      text: AppLocalizations.of(context)!.level_up,
      textColor: Color(0xFF05FF96),
      onTap: () {
        showDialog(context: context, builder: (context) => LevelUpDialog());
      },
    );
  }
}

class _CharacterRowButton extends StatelessWidget {
  final String imageAsset;
  final String text;
  final Color textColor;
  final Function() onTap;

  const _CharacterRowButton({
    Key? key,
    required this.imageAsset,
    required this.text,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 8),
      child: Ink(
        height: 42,
        decoration: BoxDecoration(
          color: theme.primaryColorLight,
          borderRadius: BorderRadius.circular(24),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(imageAsset),
                  SizedBox(width: 12),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        final localizations = AppLocalizations.of(context);

        return PagerWithIndicators(namedPages: {
          localizations!.characteristics: BaseCharateristicsPage(),
          localizations.skill: AbilitiesPage(),
          localizations.equipment: EquipmentPage(),
          if (state.clazz?.spellcastingAbility != null)
            localizations.spells: SpellsPage(),
          if (state.clazz != null && state.race != null)
            localizations.traits_and_features: TraitsAndFeaturesPage(),
        });
      },
    );
  }
}
