import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mnemonic_music_web/provider/index/player_provider.dart';
import 'package:mnemonic_music_web/provider/index/sheet_list_provider.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';

class SheetList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);
    PlayerProvider pp = Provider.of<PlayerProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: tp.background,
        border: Border(
          right: BorderSide(
            width: S.w(2),
            color: tp.primary
          )
        )
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: _MainList()
          ),
          Offstage(
            offstage: pp.playlist.length == 0,
            child: _PlayingInfo()
          ),
        ],
      ),
    );
  }
}

class _MainList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);
    SheetListProvider sheetListProvider = Provider.of<SheetListProvider>(context);

    return ListView.builder(
      itemCount: sheetListProvider.list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () { 
            sheetListProvider.currentIndex = index;
          },
          child: Container(
            color: sheetListProvider.currentIndex == index ? tp.btnBg : tp.background,
            padding: EdgeInsets.fromLTRB(S.w(10), S.w(10), S.w(10), S.w(10)),
            child: _SheetListItem(
              left: Image.network(
                sheetListProvider.list[index].imageUrl,
                fit: BoxFit.fill,
              ), 
              title: sheetListProvider.list[index].name, 
              showSubtitle: false,
              titleFontSize: S.w(14),
              titleColor: sheetListProvider.currentIndex == index ? tp.btnText : tp.font,
              bold:  sheetListProvider.currentIndex == index,
            )
          )
        );
      }
    );
  }
}

class _PlayingInfo extends StatelessWidget {
  const _PlayingInfo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);
    PlayerProvider pp = Provider.of<PlayerProvider>(context);

    return _SheetListItem(
      title: pp.currentPlayingItem.name,
      titleColor: tp.font,
      subtitle: pp.currentPlayingItem.singer,
      subtitleColor: tp.font,
      height: S.h(80),
      border: Border(
        top: BorderSide(
          color: tp.primary,
          width: S.h(2)
        )
      ),
      left: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(S.w(10)),
        color: tp.btnBg,
        child: Icon(
          Icons.music_note,
          // size: S.w(40),
          color: tp.btnText,
        ),
      ),
    );
  }
}

class _SheetListItem extends StatelessWidget {

  final Widget left;
  final String title;
  final String subtitle;
  final double height;
  final bool showSubtitle;
  final double titleFontSize;
  final double subtitleFontSize;
  final Color titleColor;
  final Color subtitleColor;
  final bool bold;
  final Border border;

  _SheetListItem({Key key, @required this.left, this.height,
    @required this.title, this.subtitle = "", this.showSubtitle = true,
    this.titleFontSize, this.subtitleFontSize, 
    this.titleColor, this.subtitleColor, this.bold, this.border}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Container(
      height: height ?? S.w(50),
      decoration: BoxDecoration(
        border: border ?? null
      ),
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              child: Center(
                child: left,
              ),
            ),
          ),
          SizedBox(width: S.w(10),),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleFontSize ?? S.w(17),
                    color: titleColor ?? tp.btnText,
                    fontWeight: bold ?? false ? FontWeight.bold : FontWeight.normal
                  ),
                ),
                showSubtitle ? Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: subtitleFontSize ?? S.w(15),
                    color: subtitleColor ?? tp.font,
                  ),
                ) : Container(),
              ],
            )
          ),
          SizedBox(width: S.w(7),),
        ],
      )
    );
  }
}