import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/pages/init.dart';
import 'package:mnemonic_music_web/pages/login.dart';
import 'package:mnemonic_music_web/provider/index/sheet_list_provider.dart';
import 'package:mnemonic_music_web/utils/network.dart';
import 'package:mnemonic_music_web/utils/router.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';
import 'package:provider/provider.dart';
import 'package:mnemonic_music_web/provider/index/player_provider.dart';
import 'package:mnemonic_music_web/provider/index/song_list_provider.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => SongListProvider()),
      ChangeNotifierProvider(create: (context) => PlayerProvider()),
      ChangeNotifierProvider(create: (context) => SheetListProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "mnemonic-music-web",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _Main()
      ),
      onGenerateRoute: onGenerateRoute,
    );
  }
}

class _Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    S.init(
      context: context,
      designWidthPx: 1280,
      designHeightPx: 800,
    );

    Network.init();

    // return InitPage();
    return Login();
  }
}