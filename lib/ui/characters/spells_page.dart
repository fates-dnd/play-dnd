import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/bloc/character/spell_slots.dart';
import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/ui/spells/spell_item.dart';
import 'package:dnd_player_flutter/ui/spells/spells_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dnd_player_flutter/utils.dart';

class SpellsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        return ListView(
          children: [
            Padding(padding: EdgeInsets.only(top: 8)),
            _SpellcastingInfoRow(),
            _EditSpellsButton(),
          ]..addAll(_unwrapSpells(state.groupedSpells, state.levelSpellSlots)),
        );
      },
    );
  }

  List<Widget> _unwrapSpells(
    Map<int, List<Spell>>? spells,
    Map<int, SpellSlots>? spellSlots,
  ) {
    final result = <Widget>[];
    if (spells == null) {
      return result;
    }

    spells.forEach((key, value) {
      result.add(_SpellLevelTitleRow(
          level: key, spellSlots: spellSlots != null ? spellSlots[key] : null));

      value.forEach((spell) {
        result.add(Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: SpellItem(
            spell: spell,
            isPrepared: true,
          ),
        ));
      });
    });

    return result;
  }
}

class _SpellcastingInfoRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
              color: theme.primaryColorLight,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SpellcastingInfoItem(
                  modifier: state.spellcastingModifier?.toBonusString() ?? "",
                  description: "модификатор"),
              _SpellcastingInfoItem(
                  modifier: state.spellcastingAttack?.toBonusString() ?? "",
                  description: "атака"),
              _SpellcastingInfoItem(
                  modifier: state.spellSavingThrow.toString(),
                  description: "спас бросок"),
            ],
          ),
        );
      },
    );
  }
}

class _SpellcastingInfoItem extends StatelessWidget {
  final String modifier;
  final String description;

  const _SpellcastingInfoItem(
      {Key? key, required this.modifier, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          modifier,
          style: TextStyle(fontSize: 32),
        ),
        Text(
          description,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class _EditSpellsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
      builder: (context, state) {
        return OutlinedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return SpellsList(
                clazz: state.clazz,
                preparedSpells: state.preparedSpells ?? [],
                learnedSpells: state.learnedSpells ?? [],
                onSpellsUpdated: (newPreparedSpells, newLearnedSpells) {
                  BlocProvider.of<CharacterBloc>(context)
                      .add(UpdateSpells(newPreparedSpells, newLearnedSpells));
                },
              );
            }));
          },
          child: Text("Добавить"),
        );
      },
    );
  }
}

class _SpellLevelTitleRow extends StatelessWidget {
  final int level;
  final SpellSlots? spellSlots;

  const _SpellLevelTitleRow({
    Key? key,
    required this.level,
    required this.spellSlots,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Круг " + level.toString(),
            style: TextStyle(color: Color(0xFFDCDAD9), fontSize: 24),
          ),
        ),
      ]..addAll(
          List.generate(
            spellSlots?.totalSlots ?? 0,
            (index) => Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: 50,
                height: 50,
                color: Colors.red,
              ),
            ),
          ),
        ),
    );
  }
}
