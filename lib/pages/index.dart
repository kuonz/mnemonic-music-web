import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/components/index/controller_bar/controller_bar.dart';
import 'package:mnemonic_music_web/components/index/song_list.dart';
import 'package:mnemonic_music_web/components/index/sheet_list.dart';
import 'package:mnemonic_music_web/components/index/top_bar.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';


class IndexPage extends StatelessWidget {
  const IndexPage({Key key, Object arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Container(
          height: S.h(60),
          child: TopBar()
        ),
        Expanded(
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SheetList()
                ),
                Expanded(
                  flex: 4,
                  child: SongList()
                )
              ],
            ),
          ),
        ),
        Container(
          height: S.h(60),
          child: ControllerBar()
        )
      ]
    );
  }
}