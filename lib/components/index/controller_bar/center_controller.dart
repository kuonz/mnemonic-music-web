import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/provider/index/player_provider.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';
import 'package:provider/provider.dart';

class CenterController extends StatefulWidget {
  CenterController({Key key}) : super(key: key);

  @override
  _ProgressControllerState createState() => _ProgressControllerState();
}

class _ProgressControllerState extends State<CenterController> {

  @override
  Widget build(BuildContext context) {

    PlayerProvider pp = Provider.of<PlayerProvider>(context);

    return StreamBuilder<Duration>(
      stream: pp.player.durationStream,
      builder: (context, snapshot) {
        final duration = snapshot.data ?? Duration.zero;
        return StreamBuilder<Duration>(
          stream: pp.player.getPositionStream(),
          builder: (context, snapshot) {
            var position = snapshot.data ?? Duration.zero;
            if (position > duration) {
              position = duration;
            }
            return Container(
              width: S.w(650),
              child: SeekBar(
                duration: duration,
                position: position,
                onChangeEnd: (newPosition) {
                  pp.player.seek(newPosition);
                },
              )
            );
          },
        );
      },
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final ValueChanged<Duration> onChangeEnd;

  SeekBar({
    @required this.duration,
    @required this.position,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {

  double _dragValue;

  @override
  Widget build(BuildContext context) {

    String _getTime(int seconds) {
      int minute = seconds ~/ 60;
      int second = seconds - minute * 60;

      String minuteStr = minute.toString();
      String secondStr = second.toString();
      if (secondStr.length < 2) {
        secondStr = "0" + secondStr;
      }

      return minuteStr + ":" + secondStr;
    }

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Row(
      children: <Widget>[
        SizedBox(width: S.w(10),),
        Text(
          _getTime(widget.position.inSeconds),
          style: TextStyle(
            color: tp.btnBg
          ),
        ),
        SizedBox(width: S.w(10),),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: tp.btnBg,
              inactiveTrackColor: tp.background,
              thumbColor: tp.btnBg,
              overlayShape: RoundSliderThumbShape(
                enabledThumbRadius: S.w(8),
              ),
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: S.w(7),
              ),
            ),
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: _dragValue ?? widget.position.inMilliseconds.toDouble(),
              onChanged: (val) {
                setState(() {
                  _dragValue = val;
                });
              },
              onChangeEnd: (value) {
                _dragValue = null;
                widget.onChangeEnd(Duration(milliseconds: value.round()));
              },
            )
          ),
        ),
        SizedBox(width: S.w(10),),
        Text(
          _getTime(widget.duration.inSeconds),
          style: TextStyle(
            color: tp.btnBg
          ),
        ),
        SizedBox(width: S.w(10),),
      ],
    );
  }
}