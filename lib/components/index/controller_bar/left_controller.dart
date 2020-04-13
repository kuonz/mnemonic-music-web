import 'dart:math';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mnemonic_music_web/provider/index/player_provider.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';
import 'package:mnemonic_music_web/utils/toast.dart';
import 'package:provider/provider.dart';

class LeftController extends StatefulWidget {

  LeftController({Key key}) : super(key: key);

  @override
  _LeftControllerState createState() => _LeftControllerState();
}

class _LeftControllerState extends State<LeftController> {

  int _randomIndex(int limit) {
    return Random(DateTime.now().millisecondsSinceEpoch).nextInt(limit);
  }


  @override
  Widget build(BuildContext context) {

    PlayerProvider pp = Provider.of<PlayerProvider>(context);

    return StreamBuilder<FullAudioPlaybackState>(
      stream: pp.player.fullPlaybackStateStream,
      builder: (context, snapshot) {
        final fullState = snapshot.data;
        final state = fullState?.state;
              
        if (pp.enable && state == AudioPlaybackState.completed) {
          switch (pp.modeIndex) {
            case 0: // 顺序播放
              pp.next();
              break;
            case 1: // 单曲循环
              pp.repeat();
              break;
            case 2: // 随机播放
              pp.playAtIndex(_randomIndex(pp.playlist.length));
              break;
          }
        }

        return Row(
          children: <Widget>[
            pp.loading ? _Loading() : Container(),
            pp.failed ? _LoadFailed() : Container(),
            SizedBox(width: S.w(10),),
            _CustomizedIconButton(
              enable: pp.enable,
              iconData: Icons.skip_previous,
              cb: () {
                pp.previous(context);
              }
            ),
            SizedBox(width: S.w(10)),
            _CustomizedIconButton(
              enable: pp.enable,
              iconData: pp.playing ? Icons.pause_circle_filled : Icons.play_circle_filled,
              cb: () {
                if (pp.playing) {
                  pp.pause();
                } else {
                  pp.play(context);
                }
              }
            ),
            SizedBox(width: S.w(10)),
            _CustomizedIconButton(
              enable: pp.enable,
              iconData: Icons.skip_next,
              cb: () {
                pp.next();
              },
            )
          ],
        );
      },
    );
  }
}

class _CustomizedIconButton extends StatelessWidget {

  final bool enable;
  final IconData iconData;
  final double iconSize;
  final VoidCallback cb;

  const _CustomizedIconButton({Key key, this.iconSize, @required this.enable, 
    @required this.iconData, @required this.cb}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        if (enable) {
          cb();
        }
      },
      child: Icon(
        iconData,
        size: iconSize ?? S.w(35),
        color: tp.btnBg,
      )
    );
  }
}

class _LoadFailed extends StatelessWidget {
  const _LoadFailed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Icon(
        Icons.error,
        color: Colors.red,
        size: S.w(25),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    return Container(
      width: S.w(20),
      height: S.w(20),
      child: CircularProgressIndicator(
        backgroundColor: tp.primary,
        valueColor: AlwaysStoppedAnimation(tp.font)
      ),
    );
  }
}