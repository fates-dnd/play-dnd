import 'package:dnd_player_flutter/bloc/races/races_bloc.dart';
import 'package:dnd_player_flutter/characters/character_list.dart';
import 'package:dnd_player_flutter/repository/races_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RacesBloc(RacesRepository())..add(LoadRaces()),
          )
        ],
        child: MaterialApp(
          title: 'DnD',
          theme: ThemeData(
            primaryColor: Color(0xFF1A1E21),
            primaryColorLight: Color(0xFF272E32),
            accentColor: Color(0xFFFF5251),
            backgroundColor: Color(0xFF1A1E21),
            scaffoldBackgroundColor: Color(0xFF1A1E21),
            textTheme: TextTheme(
              headline1: TextStyle(
                // page titles
                fontSize: 32,
                color: Color(0xFFE5E1DE),
              ),
              headline2: TextStyle(
                  // bigger headlines in the root of views
                  fontSize: 24,
                  color: Color(0xFFDCDAD9)),
              headline5: TextStyle(
                  // section titles
                  fontSize: 18,
                  color: Color(0xFFDCDAD9)),
              subtitle1: TextStyle(
                  // subtitles
                  fontSize: 12,
                  color: Color(0xFF9D9D9D)),
              bodyText1: TextStyle(
                // small titles
                fontSize: 12,
                color: Color(0x99DCDAD9),
              ),
              bodyText2: TextStyle(
                // regular text
                fontSize: 12,
                color: Color(0xFFDCDAD9),
              ),
            ),
          ),
          home: CharacterList(),
        ));
  }
}
