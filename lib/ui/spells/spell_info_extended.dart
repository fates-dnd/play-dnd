import 'package:dnd_player_flutter/dto/spell.dart';
import 'package:dnd_player_flutter/ui/spells/spell_description_row.dart';
import 'package:flutter/material.dart';

class SpellInfoExtended extends StatelessWidget {
  final Spell spell;

  const SpellInfoExtended({Key? key, required this.spell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dialogHeight = MediaQuery.of(context).size.height * 0.8;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: dialogHeight),
            decoration: BoxDecoration(
                color: theme.primaryColorLight,
                borderRadius: BorderRadius.circular(8)),
            child: ListView(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                Text(
                  spell.name,
                  style: TextStyle(fontSize: 24, color: Color(0xFFDCDAD9)),
                ),
                Text(
                  spell.school.toString(),
                  style: TextStyle(fontSize: 10, color: Color(0xCCDCDAD9)),
                ),
                SizedBox(height: 12),
                SpellDescriptionRow(name: "Время", value: spell.castingTime),
                SpellDescriptionRow(name: "Дистанция", value: spell.range),
                SpellDescriptionRow(
                    name: "Компоненты", value: spell.components.join(", ")),
                SpellDescriptionRow(
                    name: "Длительность", value: spell.duration),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    height: 1,
                    color: Color(0xFFDCDAD9),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  spell.description.join("\n\n"),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 24),
                if (spell.damage?.damageAtCharacterLevel != null)
                  _DamagePerCharacterLevel(
                      damagePerCharacterLevel:
                          spell.damage?.damageAtCharacterLevel),
                if (spell.damage?.damageAtSlotLevel != null)
                  _DamagePerSpellLevel(
                      damageAtSpellLevel: spell.damage?.damageAtSlotLevel),
                if (spell.healAtSlotLevel != null)
                  _HealPerSpellLevel(healPerSpellLevel: spell.healAtSlotLevel)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DamagePerSpellLevel extends StatelessWidget {
  final Map<String, String>? damageAtSpellLevel;

  const _DamagePerSpellLevel({Key? key, required this.damageAtSpellLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Урон на кругах:",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 4),
        _EffectAtLevel(
          descString: "Круг",
          effectAtSpellLevel: damageAtSpellLevel,
        ),
      ],
    );
  }
}

class _DamagePerCharacterLevel extends StatelessWidget {
  final Map<String, String>? damagePerCharacterLevel;

  const _DamagePerCharacterLevel(
      {Key? key, required this.damagePerCharacterLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Урон на уровне:",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 4),
        _EffectAtLevel(
          descString: "Уровень",
          effectAtSpellLevel: damagePerCharacterLevel,
        )
      ],
    );
  }
}

class _HealPerSpellLevel extends StatelessWidget {
  final Map<String, String>? healPerSpellLevel;

  const _HealPerSpellLevel({Key? key, this.healPerSpellLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Лечение на кругах:",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 4),
        _EffectAtLevel(
            descString: "Круг", effectAtSpellLevel: healPerSpellLevel),
      ],
    );
  }
}

class _EffectAtLevel extends StatelessWidget {
  final String descString;
  final Map<String, String>? effectAtSpellLevel;

  const _EffectAtLevel({
    Key? key,
    required this.descString,
    required this.effectAtSpellLevel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: effectAtSpellLevel?.entries
              .map((e) => Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "$descString ${e.key}: ",
                        style:
                            TextStyle(color: Color(0xAADCDAD9), fontSize: 14)),
                    TextSpan(text: e.value, style: TextStyle(fontSize: 14)),
                  ])))
              .toList() ??
          [],
    );
  }
}
