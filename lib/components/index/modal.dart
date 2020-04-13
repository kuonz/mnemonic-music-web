import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';
import 'package:provider/provider.dart';

class _Top extends StatelessWidget {

  final String title;

  const _Top({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: tp.primary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(S.w(10))
        )
      ),
      height: S.h(55),
      width: double.infinity,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: S.w(15),
            color: tp.font
          ),
        )
      )
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () { Navigator.of(context).pop(); },
      child: Container(
        decoration: BoxDecoration(
          color: tp.primary,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(S.w(10))
          )
        ),
        height: S.h(55),
        width: double.infinity,
        child: Center(
          child: Text(
            "关闭",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: S.w(15),
              color: tp.font
            ),
          )
        )
      ),
    );
  }
}

class Modal extends Dialog {

  final String title;
  final Widget child;

  Modal({@required this.title, @required this.child});
  
  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: S.w(550),
          height: S.h(550),
          decoration: BoxDecoration(
            color: tp.background,
            borderRadius: BorderRadius.all(
              Radius.circular(S.w(10))
            )
          ),
          child: Column(
            children: <Widget>[
              _Top(title: title),
              Expanded(
                child: child
              ),
              _Bottom()
            ]
          )
        ),
      )
    );
  }
}