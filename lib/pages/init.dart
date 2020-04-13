import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/pages/index.dart';
import 'package:mnemonic_music_web/pages/login.dart';
import 'package:mnemonic_music_web/provider/index/player_provider.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';
import 'package:mnemonic_music_web/utils/storage.dart';
import 'package:provider/provider.dart';

class InitPage extends StatefulWidget {
  InitPage({Key key}) : super(key: key);

  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  
  bool _onceDone;
  Future<bool> _futureDone;

  Future<bool> _future() async {
    await Storage.init();
    return true;
  }

  @override
  void initState() { 
    super.initState();
    _onceDone = false;
    _futureDone = _future();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _futureDone,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (!_onceDone) {
              ThemeProvider tp = Provider.of<ThemeProvider>(context);
              PlayerProvider pp = Provider.of<PlayerProvider>(context);

              tp.themeInit = Storage.datas["theme"];
              pp.modeIndexInit = Storage.datas["modeIndex"];
              pp.volumeInit = Storage.datas["volume"];
              pp.playlistJsonDecode(json.decode(Storage.datas["playlist"]));

              _onceDone = true;
            }

            if (Storage.datas["jwt"] != "empty") {
              return Container();
            }
            return Login();
          default:
            return Center(child: Text("Loading ..."),);
        }
      }
    );
  }
}