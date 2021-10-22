import 'package:dnd_player_flutter/bloc/character_creator/character_creator_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:dnd_player_flutter/ui/character_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hive_utils.dart';

void main() async {
  setupTypeAdapters();
  await Hive.initFlutter();
  await Hive.openBox('characters');

  registerDependencies();

  runApp(DndApp());
}

class DndApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                CharacterCreatorBloc(getIt.get<CharacterRepository>()))
      ],
      child: MaterialApp(
        title: 'DnD',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            secondary: Color(0xFFFF5251),
          ),
          primaryColor: Color(0xFF1A1E21),
          primaryColorLight: Color(0xFF272E32),
          scaffoldBackgroundColor: Color(0xFF1A1E21),
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color(0xFF1A1E21),
            ),
            color: Color(0xFF1A1E21),
            toolbarTextStyle: TextStyle(color: Colors.white),
            elevation: 0,
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
            subtitle1: TextStyle(
                // description text
                fontSize: 16,
                color: Color(0xFF9D9D9D)),
            subtitle2: TextStyle(
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
          inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(color: Color(0xAAE5E1DE), fontSize: 18),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF5251), width: 2)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF5251), width: 2)),
              border: UnderlineInputBorder()),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
            primary: Color(0xFFFF5251),
            side: BorderSide(color: Color(0xFFFF5251), width: 3),
          )),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  primary: Color(0xFF38282D),
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                  backgroundColor: Color(0xFFFF5251))),
          dialogTheme: DialogTheme(
              backgroundColor: Color(0xFF272E32),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 18)),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => CharacterList(),
        },
      ),
    );
  }
}
