import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/components/index/modal.dart';
import 'package:provider/provider.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';

class _Logo extends StatelessWidget {
  const _Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Container(
      color: tp.primary,
      padding: EdgeInsets.fromLTRB(S.w(30), 0, S.w(10), 0),
      child: Center(
        child: Text(
          "Mnemonic Music",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: S.w(20),
            color: tp.font
          ),
        ),
      )
    );
  }
}

class _Search extends StatelessWidget {
  const _Search({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Container(
      width: S.w(300),
      margin: EdgeInsets.fromLTRB(0, S.h(10), 0, S.h(10)),
      child: TextField(
        decoration: InputDecoration(
          prefixIconConstraints: BoxConstraints(
            minWidth: S.w(35)
          ),
          prefixIcon: Icon(
            Icons.search,
            color: tp.font,
            size: S.w(18),
          ),
          hintText: "暂不支持搜索功能",
          contentPadding: EdgeInsets.fromLTRB(S.w(0), 0, 0, 0),
          hintStyle: TextStyle(
            fontSize: S.h(20),
            color: tp.font
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius:BorderRadius.circular(1),
            borderSide: BorderSide(
              color: tp.font, //边线颜色为白色
              width: 1, //边线宽度为1
            ),
          ),
            
        ),
        enabled: false,
      ),
    );
  }
}

class _User extends StatelessWidget {
  const _User({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Container(
      color: tp.btnBg,
      height: double.infinity,
      margin: EdgeInsets.fromLTRB(0, S.w(8), 0, S.w(8)),
      padding: EdgeInsets.fromLTRB(S.w(10), 0, S.w(10), 0),
      child: Center(
        child: Text(
          "访客模式",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: S.h(18),
            color: tp.btnText
          ),
        )
      )
    );
  }
}

class _Skin extends StatelessWidget {
  const _Skin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          child: Modal(
            title: "主题选择", 
            child: _SkinDetail()
          )
        );
      },
      child: Icon(
        Icons.color_lens,
        color: tp.btnBg,
      ),
    );
  }
}

class _SkinDetail extends StatefulWidget {
  _SkinDetail({Key key}) : super(key: key);

  @override
  _SkinDetailState createState() => _SkinDetailState();
}

class _SkinDetailState extends State<_SkinDetail> {

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: S.h(3),
            color: tp.font
          ),
          bottom: BorderSide(
            width: S.h(3),
            color: tp.font
          )
        )
      ),
      child: Row(
        children: List<Widget>.generate(tp.list.length, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                tp.theme = index;
              },
              child: Container(
                color: tp.list[index][1],
                child: tp.themeIndex == index ?  Center(
                  child: Icon(
                    Icons.done,
                    color: tp.font,
                  ),
                ) : Container(),
              ),
            )
          );
        })
      ),
    );
  }
}

class _About extends StatelessWidget {
  const _About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          child: Modal(
            title: "关于", 
            child: _AboutDetail()
          )
        );
      },
      child: Icon(
        Icons.info,
        color: tp.btnBg,
      ),
    );
  }
}

class _AboutDetail extends StatelessWidget {
  const _AboutDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Container(
      margin: EdgeInsets.all(S.w(20)),
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Mnemonic Music",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: S.w(50),
                      color: tp.font
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: tp.font,
              indent: S.w(25),
              endIndent: S.w(25),
              height: S.h(5),
              thickness: S.h(3),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: S.h(20),),
                    Text(
                      "created by: kuonz",
                      style: TextStyle(
                        color: tp.font,
                        fontSize: S.w(25),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: S.h(20),),
                    Text(
                      "kuonz@outlook.com",
                      style: TextStyle(
                        color: tp.font,
                        fontSize: S.w(25),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: S.h(20),),
                    Text(
                      "github.com/kuonz/mnemonic-music-web",
                      style: TextStyle(
                        color: tp.font,
                        fontSize: S.w(25),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Row(
      children: <Widget>[
        _Logo(),
        Expanded(
          child: Container(
            color: tp.primary,
            height: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _Search(),
                SizedBox(width: S.w(100)),
                _User(),
                SizedBox(width: S.w(70)),
                _Skin(),
                SizedBox(width: S.w(20)),
                _About(),
                SizedBox(width: S.w(20)),
              ],
            ),    
          )
        )
      ],
    );
  }
}