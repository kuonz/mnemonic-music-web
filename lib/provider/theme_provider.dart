import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/utils/storage.dart';

class ThemeProvider with ChangeNotifier {

  final List<List<Color>> _customizedThemes = <List<Color>>[
    // _background, _primary
    // _font,
    // _btnBg, _btnText
    // _btnBgDisable, _btnTextDisable
    <Color>[ // 008764
      Color(0xFF4BA48D), Color(0xFF008764), 
      Color(0xFFFFFFFF), 
      Color(0xFFFFFFFF), Color(0xFF000000),
      Color(0xFFABB0BF), Color(0xFF808080)
    ],
    <Color>[
      Color(0xFF1c6c82), Color(0xFF134857), 
      Color(0xFFFFFFFF), 
      Color(0xFFFFFFFF), Color(0xFF000000),
      Color(0xFFABB0BF), Color(0xFF808080)
    ],
    <Color>[
      Color(0xFFD3293A), Color(0xFFA61B29), 
      Color(0xFFFFFFFF), 
      Color(0xFFFFFFFF), Color(0xFF000000),
      Color(0xFFABB0BF), Color(0xFF808080)
    ],
    <Color>[
      Color(0xFF404040), Color(0xFF2E2E2E), 
      Color(0xFFFFFFFF), 
      Color(0xFFCCCCCC), Color(0xFF000000),
      Color(0xFFABB0BF), Color(0xFF808080)
    ]
  ];

  // 状态
  int _themeIndex;
  Color _background;
  Color _primary;
  Color _font;
  Color _btnBg;
  Color _btnText;
  Color _btnBgDisable;
  Color _btnTextDisable;

  ThemeProvider() {
    _setTheme(0);
  }

  // 获取状态
  int get themeIndex => this._themeIndex;
  Color get background => _background;
  Color get primary => _primary;
  Color get font => _font;
  Color get btnBg => _btnBg;
  Color get btnText => _btnText;
  Color get btnBgDisable => _btnBgDisable;
  Color get btnTextDisable => _btnTextDisable;
  List<List<Color>> get list => _customizedThemes;

  // 改变状态
  set theme(int index) => this._setThemeAndNotify(index);
  set themeInit(int index) => _setTheme(index);

  _setThemeAndNotify(int index) {
    _setTheme(index);
    notifyListeners();
    Storage.setInt("theme", index);
  }

  _setTheme(int index) {
    _themeIndex = index;
    _background = _customizedThemes[index][0];
    _primary = _customizedThemes[index][1];
    _font = _customizedThemes[index][2];
    _btnBg = _customizedThemes[index][3];
    _btnText = _customizedThemes[index][4];
    _btnBgDisable = _customizedThemes[index][5];
    _btnTextDisable = _customizedThemes[index][6];
  }
}