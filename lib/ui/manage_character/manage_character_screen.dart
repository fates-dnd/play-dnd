import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/bloc/character_list/character_list_bloc.dart';
import 'package:dnd_player_flutter/ui/manage_character/manage_ability_scores_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ManageCharacterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.manage_character),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  _ManageMenuItem(
                    title: localizations.manage_ability_scores,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ManageAbilityScoresScreen())),
                  ),
                  _ManageMenuItem(
                    title: localizations.manage_proficiencies,
                    onTap: () {},
                  ),
                ],
              )),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<CharacterBloc>(context)
                        .add(DeleteCharacter());
                    BlocProvider.of<CharacterListBloc>(context)
                        .add(LoadCharacterList());
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)),
                  child: Text(
                    localizations.delete_character,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ManageMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ManageMenuItem({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          children: [
            Expanded(
                child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            )),
            Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
