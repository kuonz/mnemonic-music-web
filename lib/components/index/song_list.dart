import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/provider/index/song_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:mnemonic_music_web/model/music_model.dart';
import 'package:mnemonic_music_web/provider/index/player_provider.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';
import 'package:mnemonic_music_web/utils/toast.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';
import 'package:mnemonic_music_web/components/index/selectable_button.dart';

class _MultiSelect extends StatelessWidget {
  const _MultiSelect({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SongListProvider sdp = Provider.of<SongListProvider>(context);

    return SelectableButton(
      title: "批量选择",
      cb: () {
        if (sdp.canSelect) {
          sdp.indexSetClear();
        }
        sdp.canSelect = !sdp.canSelect;
      },
      selectable: true,
      selectedTitle: "取消批量选择",
      initSelect: sdp.canSelect,
    );
  }
}

class _SelectAll extends StatelessWidget {
  const _SelectAll({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SongListProvider sdp = Provider.of<SongListProvider>(context);

    return Container(
      padding: EdgeInsets.only(left: S.w(10)),
      child: SelectableButton(
        title: "全部选择",
        cb: () {
          if (sdp.indexSet.length != 5) {
            for (int i=0; i<5; i++) {
              sdp.indexSetAdd(i);
            }
          } else {
            sdp.indexSetClear();
          }
        },
        selectable: true,
        selectedTitle: "取消全部选择",
        initSelect: sdp.indexSet.length == 5,
      ),
    );
  }
}

class _AddToPlaylist extends StatelessWidget {
  const _AddToPlaylist({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SongListProvider sdp = Provider.of<SongListProvider>(context);
    PlayerProvider pp = Provider.of<PlayerProvider>(context);
    SongListProvider songListProvider = Provider.of<SongListProvider>(context);

    return SelectableButton(
      title: "添加进播放列表",
      cb: () {
        int _volumn = 50 - pp.playlist.length;
        if (sdp.indexSet.length > _volumn) {
          Toast.show(
            context: context, 
            msg: "列表歌曲数量最大为50，当前空余：" + _volumn.toString()
          );
        } else {
          var indexList = sdp.indexSet.toList();
          indexList.sort();
          indexList.forEach((index) {
            pp.playlistAppend(songListProvider.list[index]);
          });
          pp.playlistNotify();
          sdp.indexSet.clear();
          sdp.canSelect = false;
          Toast.show(
            context: context, 
            msg: "添加成功",
          );
        }
      },
      disable: sdp.indexSet.length == 0,
    );
  }
}

class SongList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SongListProvider sdp = Provider.of<SongListProvider>(context);
    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Container(
      color: tp.background,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: S.h(2),
                  color: tp.primary
                )
              )
            ),
            child: Row(
              children: <Widget>[
                SizedBox(width: S.w(25),),
                _MultiSelect(),
                Offstage(
                  offstage: !sdp.canSelect,
                  child: _SelectAll()
                ),
                SizedBox(width: S.w(10),),
                _AddToPlaylist()
              ]
            ),
          ),
          Expanded(
            child: _Table(),
          )
        ],
      )
    );
  }
}

class _Table extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SongListProvider songListProvider = Provider.of<SongListProvider>(context);

    return ListView.builder(
      itemCount: songListProvider.list.length,
      itemBuilder: (context, index) {
        return _TableItem(
          key: UniqueKey(),
          item: songListProvider.list[index],
          index: index,
        );
      }
    );
  }
}

class _TableItem extends StatelessWidget {

  final MusicModel item;
  final int index;

  _TableItem({Key key, @required this.item, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);
    SongListProvider sdp = Provider.of<SongListProvider>(context);
    PlayerProvider pp = Provider.of<PlayerProvider>(context);

    return GestureDetector(
      onDoubleTap: () {
        int itemIndex = pp.playlistContains(item);
        if (itemIndex < 0) {
          pp.playlistHeadAdd(item);
        } else {
          pp.playAtIndex(itemIndex);
        }
      },
      onTap: () {
        if (sdp.canSelect) {
          if (sdp.indexSetContains(index)) {
            sdp.indexSetRemove(index);
          } else {
            sdp.indexSetAdd(index);
          }
        }
      },
      child: Container(
        width: double.infinity,
        height: S.h(70),
        color: sdp.indexSetContains(index) ? tp.btnBg : tp.background,
        padding: EdgeInsets.fromLTRB(S.w(10), 0, S.w(10), 0),
        child: Center(
          child:GestureDetector(
            child: _TableItemBar(
              index: index,
              item: item,
            )
          )
        )
      )
    );
  }
}

class _TableItemBar extends StatelessWidget {

  final int index;
  final MusicModel item;

  const _TableItemBar({Key key, @required this.index, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);
    SongListProvider sdp = Provider.of<SongListProvider>(context);

    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: S.w(50),
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: S.w(70)),              
            child: Text(
              (index+1).toString(),
              style: TextStyle(
                color: sdp.indexSetContains(index) ? tp.btnText : tp.font,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              item.name,
              style: TextStyle(
                color: sdp.indexSetContains(index) ? tp.btnText : tp.font,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              item.singer,
              style: TextStyle(
                color: sdp.indexSetContains(index) ? tp.btnText : tp.font,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: S.w(40)),
            child: Text(
              item.length,
              style: TextStyle(
                color: sdp.indexSetContains(index) ? tp.btnText : tp.font,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
        ],
      )
    );
  }
}