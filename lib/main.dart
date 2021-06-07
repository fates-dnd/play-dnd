import 'package:dnd_player_flutter/characters/character_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
    statusBarIconBrightness: Brightness.light // dark text for status bar
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DnD',
      theme: ThemeData(
        primaryColor: Color(0xFF1A1E21),
        primaryColorLight: Color(0xFF272E32),
        accentColor: Color(0xFFFF5251),
        buttonColor: Color(0xFFFF5251),
        backgroundColor: Color(0xFF1A1E21),
        scaffoldBackgroundColor: Color(0xFF1A1E21),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white
          )
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            // page titles
            fontSize: 32,
            fontWeight: FontWeight.w500,
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
          subtitle1: TextStyle( // description text
              fontSize: 16,
              color: Color(0xFF9D9D9D)),
          subtitle2: TextStyle( // subtitles
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
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Color(0xFFFF5251),
            side: BorderSide(color: Color(0xFFFF5251), width: 3),
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Color(0xFF38282D),
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            backgroundColor: Color(0xFFFF5251)
          )
        )
      ),
      home: CharacterList(),
    );
  }
}
