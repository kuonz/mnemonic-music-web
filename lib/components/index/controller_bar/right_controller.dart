import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/components/index/modal.dart';
import 'package:mnemonic_music_web/components/index/playlist.dart';
import 'package:mnemonic_music_web/provider/index/player_provider.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';
import 'package:provider/provider.dart';

class RightController extends StatefulWidget {
  RightController({Key key}) : super(key: key);

  @override
  _RightControllerState createState() => _RightControllerState();
}

class _RightControllerState extends State<RightController> {

  final List<IconData> modeList = <IconData>[
    Icons.repeat, // 0 顺序播放
    Icons.repeat_one, // 1 单曲循环
    Icons.shuffle // 2 随机播放
  ];

  @override
  Widget build(BuildContext context) {

    PlayerProvider pp = Provider.of<PlayerProvider>(context);
    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Row(
      children: <Widget>[
        Icon(
          Icons.volume_up, 
          size: S.w(30.0),
          color: tp.btnBg,
        ),
        SizedBox(width: S.w(10),),
        Container(
          width: S.w(100),
          child: _VolumeBar()
        ),
        SizedBox(width: S.w(20)),
        GestureDetector(
          onTap: () {
            setState(() {
              pp.modeIndex = (pp.modeIndex + 1) % 3;
            });
          },
          child: Icon(
            modeList[pp.modeIndex],
            size: S.w(30.0),
            color: tp.btnBg,
          ),
        ),
        SizedBox(width: S.w(20),),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              child: Modal(
                title: "播放列表", 
                child: PlayList()
              )
            );
          },
          child: Icon(
            Icons.queue_music, 
            size: S.w(32.0),
            color: tp.btnBg,
          ),
        ),
        SizedBox(width: S.w(20),),
      ],
    );
  }
}

class _VolumeBar extends StatefulWidget {
  _VolumeBar({Key key}) : super(key: key);

  @override
  _VolumeBarState createState() => _VolumeBarState();
}

class _VolumeBarState extends State<_VolumeBar> {

  double _dragValue;

  @override
  Widget build(BuildContext context) {

    PlayerProvider pp = Provider.of<PlayerProvider>(context);
    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Container(
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: tp.btnBg,
          inactiveTrackColor: tp.btnBgDisable,
          thumbColor: tp.btnBg,
          overlayShape: RoundSliderThumbShape(
            enabledThumbRadius: S.w(8),
          ),
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: S.w(7),
          ),
        ),
        child: Slider(
          min: 0,
          max: 10,
          value: _dragValue ?? pp.volume,
          onChanged: (value) {
            setState(() {
              _dragValue = value;
            });
          },
          onChangeEnd: (value) {
            pp.volume = value.round();
            pp.player.setVolume(value.round() / 10);
          },
        )
      ),
    );
  }
}