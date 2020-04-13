import 'package:flutter/material.dart';

class S {
  static void init({@required BuildContext context, @required double designWidthPx, 
    @required double designHeightPx}) {

    _ScreenUtil.init(
      context: context,
      designWidthPx: designWidthPx, 
      designHeightPx: designHeightPx
    );
  }

  static double get screenWidth => _ScreenUtil._screenWidthDp;
  static double get screenHeight => _ScreenUtil._screenHeightDp;
  static double get statusBarHeight => _ScreenUtil._statusBarHeight;
  static double get bottomBarHeight => _ScreenUtil._bottomBarHeight;

  static double w(double width) => _ScreenUtil._fixWidth(width);
  static double h(double height) => _ScreenUtil._fixHeight(height);

  static void showScreenInfo() => print(_ScreenUtil._screenInfo());
}

class _ScreenUtil {
  // 传入得到
  static double _uiWidthPx;
  static double _uiHeightPx;
  // 查询得到
  static double _pixelRatio;
  static double _screenWidthDp;
  static double _screenHeightDp;
  static double _statusBarHeight;
  static double _bottomBarHeight;
  // 计算得到
  static double _scaleWidthRatio;
  static double _scaleHeightRatio;

  // 初始化
  static void init({
    @required BuildContext context,
    @required double designWidthPx,
    @required double designHeightPx,
  }) {
    // 传入
    _uiWidthPx = designWidthPx;
    _uiHeightPx = designHeightPx;
    // 查询
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    _pixelRatio = _mediaQueryData.devicePixelRatio;
    _screenWidthDp = _mediaQueryData.size.width;
    _screenHeightDp = _mediaQueryData.size.height;
    _statusBarHeight = _mediaQueryData.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    // 计算
    // if (_screenWidthDp < 1280) {
    //   _screenWidthDp = 1280;
    // }
    // if (_screenHeightDp < 800) {
    //   _screenHeightDp = 800;
    // }

    _scaleWidthRatio = _screenWidthDp / _uiWidthPx;
    _scaleHeightRatio = _screenHeightDp / _uiHeightPx;
  }

  // 方法
  static double _fixWidth(double width) => _scaleWidthRatio * width;
  static double _fixHeight(double height) => _scaleHeightRatio * height;

  static String _screenInfo() {
    return """\n
pixelRatio: ${_ScreenUtil._pixelRatio}
screenWidthDp: ${_ScreenUtil._screenWidthDp}
screenHeightDp: ${_ScreenUtil._screenHeightDp}
scaleWidth: ${_ScreenUtil._scaleWidthRatio}
scaleHeight: ${_ScreenUtil._scaleHeightRatio}""";
  }
}