import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/bloc/character_list/character_list_bloc.dart';
import 'package:dnd_player_flutter/bloc/settings/settings_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:dnd_player_flutter/ui/character_creator/new_char_race.dart';
import 'package:dnd_player_flutter/ui/characters/character_screen.dart';
import 'package:dnd_player_flutter/ui/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CharacterList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CharacterListState();
  }
}

class _CharacterListState extends State<CharacterList> {
  Key key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        setState(() {
          // reset character
          key = UniqueKey();
        });
      },
      child: KeyedSubtree(key: key, child: _CharacterListDisplay()),
    );
  }
}

class _CharacterListDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterListBloc(getIt.get<CharacterRepository>())
        ..add(LoadCharacterList()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.characters),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
                icon: Icon(Icons.settings)),
          ],
        ),
        body: _CharacterListBody(),
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            AppLocalizations.of(context)!.new_character,
            style: TextStyle(
                fontSize: 24, color: Theme.of(context).primaryColorLight),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewCharRace()));
          },
        ),
      ),
    );
  }
}

class _CharacterListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterListBloc, CharacterListState>(
      builder: (context, state) {
        if (state.characters.isEmpty) {
          return noCharacters();
        }

        return characterList(state.characters);
      },
    );
  }

  Widget characterList(List<Character> characters) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          return CharacterItem(character: characters[index]);
        });
  }

  Widget noCharacters() {
    return SizedBox();
  }
}

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.primaryColorLight,
      child: InkWell(
        onTap: () {
          BlocProvider.of<CharacterBloc>(context).add(SetCharacter(character));
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CharacterScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                character.clazz.imageAsset,
                width: 62,
                height: 62,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: theme.textTheme.headline2,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${character.race.name} ${character.clazz.name}",
                    style: theme.textTheme.subtitle1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
