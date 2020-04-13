import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/components/index/controller_bar/center_controller.dart';
import 'package:mnemonic_music_web/components/index/controller_bar/left_controller.dart';
import 'package:mnemonic_music_web/components/index/controller_bar/right_controller.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ControllerBar extends StatefulWidget {
  ControllerBar({Key key}) : super(key: key);

  @override
  _ControlBarState createState() => _ControlBarState();
}

class _ControlBarState extends State<ControllerBar> {

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);
    
    return Container(
      color: tp.primary,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LeftController(),
                CenterController(),
                RightController(),
              ],
            )
          )
        ],
      )
    );
  }
}