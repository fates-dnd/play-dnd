import 'package:device_info_plus/device_info_plus.dart';
import 'package:dnd_player_flutter/available_from_phone_screen.dart';
import 'package:dnd_player_flutter/bloc/character/character_bloc.dart';
import 'package:dnd_player_flutter/bloc/settings/settings_bloc.dart';
import 'package:dnd_player_flutter/dependencies.dart';
import 'package:dnd_player_flutter/repository/character_repository.dart';
import 'package:dnd_player_flutter/repository/equipment_repository.dart';
import 'package:dnd_player_flutter/repository/features_repository.dart';
import 'package:dnd_player_flutter/repository/settings_repository.dart';
import 'package:dnd_player_flutter/repository/skills_repository.dart';
import 'package:dnd_player_flutter/repository/spells_repository.dart';
import 'package:dnd_player_flutter/repository/traits_repository.dart';
import 'package:dnd_player_flutter/ui/character_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bloc/character_creator/character_creator/character_creator_bloc.dart';
import 'hive_utils.dart';

void main() async {
  setupTypeAdapters();
  await Hive.initFlutter();
  final box = await Hive.openLazyBox("characters");
  final clearBox = await shouldClearBox();
  if (clearBox) {
    await box.clear();
  }
  await box.close();

  await Hive.openBox("characters");
  registerDependencies();

  var nonMobileBrowser = false;
  try {
    final deviceInfo = DeviceInfoPlugin();
    final browserInfo = await deviceInfo.webBrowserInfo;
    final userAgent = browserInfo.userAgent?.toLowerCase();
    print("UserAgent: $userAgent");
    if (userAgent?.contains("android") == true) {
      nonMobileBrowser = false;
    } else if (userAgent?.contains("iphone") == true) {
      nonMobileBrowser = false;
    } else if (userAgent?.contains("ipad") == true) {
      nonMobileBrowser = false;
    } else {
      nonMobileBrowser = true;
    }
  } catch (e) {}

  runApp(DndApp(initialRoute: nonMobileBrowser ? "web" : "/"));
}

class DndApp extends StatelessWidget {
  final String initialRoute;

  const DndApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SettingsBloc(
                  getIt<SettingsRepository>(),
                )..add(InitSettings())),
        BlocProvider(
            create: (context) =>
                CharacterCreatorBloc(getIt.get<CharacterRepository>())),
        BlocProvider(
          create: (context) => CharacterBloc(
            getIt<SettingsRepository>(),
            getIt<CharacterRepository>(),
            getIt<SkillsRepository>(),
            getIt<EquipmentRepository>(),
            getIt<SpellsRepository>(),
            getIt<TraitsRepository>(),
            getIt<FeaturesRepository>(),
          ),
        )
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) => MaterialApp(
          title: 'DnD',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state.languageCode != null
              ? Locale(state.languageCode!, '')
              : null,
          theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: Color(0xFFFF5251),
              secondary: Color(0xFFFF5251),
            ),
            primaryColor: Color(0xFF1A1E21),
            primaryColorLight: Color(0xFF272E32),
            scaffoldBackgroundColor: Color(0xFF1A1E21),
            unselectedWidgetColor: Colors.grey,
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
                hintStyle: TextStyle(color: Color(0xAAE5E1DE), fontSize: 16),
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
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    backgroundColor: Color(0xFFFF5251))),
            dialogTheme: DialogTheme(
                backgroundColor: Color(0xFF272E32),
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          initialRoute: initialRoute,
          routes: {
            'web': (context) => AvailableFromPhoneScreen(),
            '/': (context) => CharacterList(),
          },
        ),
      ),
    );
  }
}
