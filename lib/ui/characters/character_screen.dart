import 'package:dnd_player_flutter/dto/character.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterScreen extends StatelessWidget {
  final Character character;

  const CharacterScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/background.png"),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  CharacterScreenHeader(character: character),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CharacterScreenHeader extends StatelessWidget {
  final Character character;

  const CharacterScreenHeader({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
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
                    HealthButtonIcon(),
                    InitiativeIcon(),
                    RestIcon(),
                  ],
                ),
              ),
              NotActionInfo(
                  assetUrl: "assets/stats/shield.png",
                  value: "12",
                  color: Color(0xFFADADAD)),
              SizedBox(width: 12),
              NotActionInfo(
                  assetUrl: "assets/stats/hammer.png",
                  value: "+2",
                  color: Color(0xCCFB9538)),
            ],
          )
        ],
      ),
    );
  }
}

class HealthButtonIcon extends StatelessWidget {
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

class InitiativeIcon extends StatelessWidget {
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
            Text(
              "+3",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFDCDAD9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestIcon extends StatelessWidget {
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

class NotActionInfo extends StatelessWidget {
  final String assetUrl;
  final String value;
  final Color color;

  const NotActionInfo({
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