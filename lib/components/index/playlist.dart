import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mnemonic_music_web/model/music_model.dart';
import 'package:mnemonic_music_web/provider/index/player_provider.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';
import 'package:mnemonic_music_web/components/index/selectable_button.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';


class PlayList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    PlayerProvider pp = Provider.of<PlayerProvider>(context);

    return pp.playlist.length == 0 ? _Empty() : _Main();
  }
}

class _Main extends StatelessWidget {
  const _Main({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Column(
      children: <Widget>[
        _Header(),
        Expanded(
          child: Container(
            color: tp.background,
            child: _ReorderableList(),
          )
        ),
      ],
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text(
          "列表为空，请添加歌曲到列表中",
          style: TextStyle(
            color: tp.font
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);
    PlayerProvider pp = Provider.of<PlayerProvider>(context);

    return Container(
      height: S.h(60),
      decoration: BoxDecoration(
        color: tp.background,
        // color: Colors.amber,
        border: Border(
          bottom: BorderSide(
            width: S.h(2),
            color: tp.primary
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(S.w(10), S.w(2), 0, S.w(2)),
            child: Text(
              "可以长按并拖拽进行排序",
              style: TextStyle(
                fontSize: S.w(13),
                color: tp.font
              ),
            )
          ),
          Container(
            padding: EdgeInsets.only(right: S.w(10)),
            child: SelectableButton(
              title: "清空列表", 
              cb: () {
                pp.playlistClear();
              },
            ),
          )
        ],
      )
    );
  }
}

class _ReorderableList extends StatefulWidget {
  _ReorderableList({Key key}) : super(key: key);

  @override
  _ReorderableListState createState() => _ReorderableListState();
}

class _ReorderableListState extends State<_ReorderableList> {
  @override
  Widget build(BuildContext context) {

    PlayerProvider pp = Provider.of<PlayerProvider>(context);

    List<Widget> _children = List<Widget>();
    for (int i=0; i<pp.playlist.length; i++) {
      _children.add(
        _ReorderListItem(
          key: UniqueKey(),
          index: i,
          item: pp.playlist[i]
        )
      );
    }

    return ReorderableListView(
      padding: EdgeInsets.all(0),
      children: _children,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if(oldIndex < newIndex) {
            newIndex -= 1;    
          }
          MusicModel item = pp.playlist.removeAt(oldIndex);
          pp.playlist.insert(newIndex, item);
        });
      }
    );
  }
}

class _ReorderListItem extends StatelessWidget {

  final int index;
  final MusicModel item;

  const _ReorderListItem({Key key, @required this.index, 
    @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);
    PlayerProvider pp = Provider.of<PlayerProvider>(context);

    return GestureDetector(
      onDoubleTap: () {
        pp.playAtIndex(index);
      },
      child: Container(
        width: double.infinity,
        height: S.h(60),
        color: tp.background,
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                (index+1).toString(),
                style: TextStyle(
                  color: tp.font,
                  fontWeight: FontWeight.w700
                ),
              ),
              padding: EdgeInsets.fromLTRB(S.w(20), 0, S.w(40), 0),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Text(
                  item.name,
                style: TextStyle(
                  color: tp.font,
                  fontWeight: FontWeight.w700
                ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text(
                  item.singer,
                style: TextStyle(
                  color: tp.font,
                  fontWeight: FontWeight.w700
                ),
                ),
              ),
            ),
            Container(
              child: Text(
                item.length,
                style: TextStyle(
                  color: tp.font,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                pp.playlistRemoveAt(index);
              },
              child: Container(
                child: Icon(
                  Icons.delete,
                  color: tp.font,
                ),
                padding: EdgeInsets.fromLTRB(S.w(30), 0, S.w(20), 0),
              ),
            )
          ],
        ),
      )
    );
  }
}