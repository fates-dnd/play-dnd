import 'package:dnd_player_flutter/bloc/character_list/character_list_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/dto/character.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:dnd_player_flutter/ui/character_creator/new_char_race.dart';
import 'package:dnd_player_flutter/ui/characters/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterListBloc(getIt.get<CharacterRepository>())
        ..add(LoadCharacterList()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Персонажи"),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: BlocBuilder<CharacterListBloc, CharacterListState>(
          builder: (context, state) {
            if (state.characters.isEmpty) {
              return noCharacters();
            }

            return characterList(state.characters);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Text(
            "+",
            style: TextStyle(
                fontSize: 32, color: Theme.of(context).primaryColorLight),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewCharRace()));
          },
        ),
      ),
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CharacterScreen(character: character)));
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
