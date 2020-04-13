import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';
import 'package:provider/provider.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';

class SelectableButton extends StatelessWidget {

  final String title;
  final VoidCallback cb;
  final String selectedTitle;
  final bool selectable;
  final bool initSelect;
  final bool disable;

  SelectableButton({Key key, @required this.title, @required this.cb, 
    this.selectedTitle, this.selectable = false, this.disable = false, 
    this.initSelect = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return MaterialButton(
      height: S.h(40),
      elevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      hoverColor: disable ? tp.btnBgDisable : tp.btnBg,
      color: disable ? tp.btnBgDisable : tp.btnBg,
      focusColor: disable ? tp.btnBgDisable : tp.btnBg,
      onPressed: () {
        if (!disable) { cb(); }
      },
      child: selectable ?
        Text(
          initSelect ? selectedTitle : title,
          style: TextStyle(
            color: disable ? tp.btnTextDisable : tp.btnText,
            fontWeight: FontWeight.bold,
            fontSize: S.w(12)
          ),
        ) : 
        Text(
          title,
          style: TextStyle(
            color: disable ? tp.btnTextDisable : tp.btnText,
            fontWeight: FontWeight.bold,
            fontSize: S.w(12)
          ),
        )
    );
  }
}