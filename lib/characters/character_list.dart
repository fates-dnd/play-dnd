import 'package:dnd_player_flutter/characters/new_char_race.dart';
import 'package:flutter/material.dart';

class CharacterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: noCharacters(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewCharRace()));
        },
      ),
    );
  }

  Widget characterList() {
    return ListView.builder(itemBuilder: (context, index) {
      return SizedBox();
    });
  }

  Widget noCharacters() {
    return SizedBox();
  }
}
