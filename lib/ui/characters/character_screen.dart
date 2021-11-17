import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:dnd_player_flutter/ui/characters/abilities_page.dart';
import 'package:dnd_player_flutter/ui/characters/base_characteristics_page.dart';
import 'package:dnd_player_flutter/ui/characters/equipment_page.dart';
import 'package:dnd_player_flutter/ui/characters/pager_with_indicators.dart';
import 'package:dnd_player_flutter/ui/characters/spells_page.dart';
import 'package:dnd_player_flutter/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterScreen extends StatelessWidget {
  final Character character;

  const CharacterScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterBloc(
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
                )
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            character.name,
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            "${character.race.name} ${character.clazz.name}, ${character.level}",
            style: TextStyle(
                color: Color(0xFFB5B0AE),
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
                    _HealthButtonIcon(),
                    _InitiativeIcon(),
                    _RestIcon(),
                  ],
                ),
              ),
              _NotActionInfo(
                  assetUrl: "assets/stats/shield.png",
                  value: "12",
                  color: Color(0xFFADADAD)),
              SizedBox(width: 12),
              _ProficiencyBonusInfo(),
            ],
          )
        ],
      ),
    );
  }
}

class _HealthButtonIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 62,
      height: 62,
      child: Card(
        color: theme.primaryColorLight,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/stats/heart.png"),
                  Text(
                    "14",
                    style: TextStyle(
                      color: theme.accentColor,
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
            Image.asset("assets/stats/sword.png"),
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

class _RestIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.primaryColorLight,
      shape: CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/stats/tent.png"),
      ),
    );
  }
}

class _ProficiencyBonusInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) => _NotActionInfo(
          assetUrl: "assets/stats/hammer.png",
          value: state.proficiencyBonus.toBonusString(),
          color: Color(0xCCFB9538)),
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
      width: 44,
      height: 44,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFA4A3A1), width: 3)),
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
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        return PagerWithIndicators(
          children: [
            BaseCharateristicsPage(),
            AbilitiesPage(),
            EquipmentPage(),
            if (state.clazz?.spellcastingAbility != null) SpellsPage(),
          ],
        );
      },
    );
  }
}
