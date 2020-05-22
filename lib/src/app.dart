import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novum/LiveTv/live_tv_grid.dart';
import 'package:novum/src/ui/theme/colors.dart';
import 'package:novum/version-check.dart';
import './ui/theme/theme.dart';
import './ui/screens/browse.dart';
import './ui/screens/search.dart';
import './ui/screens/auth.dart';
import 'package:flutter_villains/villain.dart';
import 'package:newsapi_client/newsapi_client.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';

final SystemUiOverlayStyle uiStyle = SystemUiOverlayStyle(
  statusBarIconBrightness: Brightness.dark,
  statusBarColor: Colors.grey[100],
  systemNavigationBarColor: Colors.white,
  systemNavigationBarIconBrightness: Brightness.dark,
  systemNavigationBarDividerColor: Colors.black26,
);

class NovumApp extends StatefulWidget {
  const NovumApp({Key key}) : super(key: key);

  @override
  NovumAppState createState() => NovumAppState();
}

class NovumAppState extends State<NovumApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final baseDark = ThemeData.dark();
    final baseLight = ThemeData.light();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    SystemChrome.setSystemUIOverlayStyle(uiStyle);
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
              // primarySwatch: Colors.indigo,


              primaryColor: kNovumWhite,
          //   primaryColorDark: Colors.black,
             // secondaryHeaderColor: Colors.red,
              // primaryColorDark: Colors.grey,
              //  primaryColor: Theme.of(context).brightness==Brightness.dark?Colors.grey:kNovumWhite,
              brightness: brightness,
              primarySwatch: Colors.deepPurple,
              textTheme: brightness == Brightness.dark
                  ? buildDarkTextTheme(baseDark.textTheme)
                  : buildLightTextTheme(baseLight.textTheme),
            ),

        //  data: (brightness)=>Theme.of(context).brightness==Brightness.dark?kNovumDarkTheme:kNovumLightTheme,
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            navigatorObservers: [VillainTransitionObserver()],
            debugShowCheckedModeBanner: false,
            theme: theme,



            title: 'Novum',
            home: Auth(),
            routes: {
              '/liveTV': (context) => LiveTvGrid(),
              '/home': (context) => Browse(title: 'Trending'),
              '/search': (context) => Search(),
              '/business': (context) =>
                  Browse(title: 'Business', category: Categories.business),
              '/entertainment': (context) => Browse(
                  title: 'Entertainment', category: Categories.entertainment),
              '/health': (context) =>
                  Browse(title: 'Health', category: Categories.health),
              '/science': (context) =>
                  Browse(title: 'Science', category: Categories.science),
              '/sports': (context) =>
                  Browse(title: 'Sports', category: Categories.sports),
              '/technology': (context) =>
                  Browse(title: 'Technology', category: Categories.technology),
            },
          );
        });
  }

}
