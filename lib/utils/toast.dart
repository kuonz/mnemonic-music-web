import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mnemonic_music_web/utils/screen_adapter.dart';
import 'package:mnemonic_music_web/provider/theme_provider.dart';

enum ToastPosition {
  top,
  center,
  bottom
}

class Toast {
  static bool _showing = false;
  static OverlayEntry _overlayEntry;

  static show({@required BuildContext context, @required String msg,
    int duration = 1000, Color toastBackgroundColor, Color toastTextColor,
    ToastPosition toastPosition = ToastPosition.top}) async {
    
    if (!_showing) {
      _showing = true;

      _overlayEntry = OverlayEntry(
        builder: (context) {
          return Material(
            type: MaterialType.transparency,
            child: _buildToastWidgt(
              context, 
              toastPosition, 
              msg, 
              toastBackgroundColor, 
              toastTextColor
            )
          );
        }
      );

      Overlay.of(context).insert(_overlayEntry);

      await Future.delayed(Duration(milliseconds: duration));
      _overlayEntry.remove();
      _overlayEntry = null;

      _showing = false;
    }
  }

  static Widget _buildToastWidgt(BuildContext context, ToastPosition toastPosition, 
    String msg, Color toastBackgroundColor, Color toastTextColor) {

    ThemeProvider tp = Provider.of<ThemeProvider>(context);

    AlignmentGeometry _alignment;
    EdgeInsetsGeometry _margin;
    
    switch(toastPosition) {
      case ToastPosition.top:
        _alignment = Alignment.topCenter;
        _margin = EdgeInsets.fromLTRB(0, 100, 0, 0);
        break;
      case ToastPosition.center:
        _alignment = Alignment.center;
        _margin = EdgeInsets.all(0);
        break;
      case ToastPosition.bottom:
        _alignment = Alignment.bottomCenter;
        _margin = EdgeInsets.fromLTRB(0, 0, 0, 100);
        break;
    }

    return Container(
      alignment: _alignment,
      child: Container(
        margin: _margin,
        padding: EdgeInsets.all(S.w(10)),
        decoration: BoxDecoration(
          color: toastBackgroundColor ?? tp.btnBg,
          borderRadius: BorderRadius.all(Radius.circular(S.w(5)))
        ),
        child: Text(
          msg,
          style: TextStyle(
            color: toastTextColor ?? tp.btnText,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}