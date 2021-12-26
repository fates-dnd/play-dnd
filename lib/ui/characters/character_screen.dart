import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:dnd_player_flutter/ui/characters/abilities_page.dart';
import 'package:dnd_player_flutter/ui/characters/base_characteristics_page.dart';
import 'package:dnd_player_flutter/ui/characters/equipment_page.dart';
import 'package:dnd_player_flutter/ui/characters/hp_dialog.dart';
import 'package:dnd_player_flutter/ui/characters/pager_with_indicators.dart';
import 'package:dnd_player_flutter/ui/characters/spells_page.dart';
import 'package:dnd_player_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CharacterScreen extends StatelessWidget {
  final Character character;

  const CharacterScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterBloc(
        getIt<SettingsRepository>(),
        getIt<CharacterRepository>(),
        getIt<SkillsRepository>(),
        getIt<EquipmentRepository>(),
        getIt<SpellsRepository>(),
      )..add(SetCharacter(character)),
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: _CharacterScreenHeader(character: character),
                ),
                SliverToBoxAdapter(
                  child: _CharacterActionsRow(),
                ),
              ];
            },
            body: Pages(),
          ),
        ),
      ),
    );
  }
}

class _CharacterScreenHeader extends StatelessWidget {
  final Character character;

  const _CharacterScreenHeader({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE5E1DE),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            character.name,
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            "${character.race.name} ${character.clazz.name}, ${character.level}",
            style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 18,
                fontStyle: FontStyle.italic),
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
      onTap: () {},
    );
  }
}

class _MoneyButtonIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _CharacterRowButton(
      imageAsset: "assets/drawable/stats/money.png",
      text: AppLocalizations.of(context)!.money,
      textColor: Color(0xFFE5DD1C),
      onTap: () {},
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
      onTap: () {},
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
      padding: const EdgeInsets.only(right: 8.0, top: 8),
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
        return PagerWithIndicators(namedPages: {
          "Характеристики": BaseCharateristicsPage(),
          "Навыки": AbilitiesPage(),
          "Снаряжение": EquipmentPage(),
          if (state.clazz?.spellcastingAbility != null)
            "Заклинания": SpellsPage(),
        });
      },
    );
  }
}
