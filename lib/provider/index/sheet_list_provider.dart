import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/model/sheet_model.dart';

class SheetListProvider with ChangeNotifier {

  // 状态
  int _currentIndex;
  List<SheetModel> _list;

  // 初始化
  SheetListProvider() {

    _currentIndex = 0;

    _list = List<SheetModel>();

    for (int i=0; i<20; i++) {
      _list.add(SheetModel(
        name: "好听的歌单-" + (i+1).toString(),
        imageUrl: "http://p2.music.126.net/ij7j_H4ZjZsFuBhH2VX_Aw==/18664209883612319.jpg?param=140y140",
        uuid: "sheet-zxcvbnmqwertyuiop"
      ));
    }
  }

  // 获取
  int get currentIndex => _currentIndex;
  List<SheetModel> get list => _list;

  // 设置
  _setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
  set currentIndex(int index) => _setCurrentIndex(index);
  //-- TODO：通过网络获取歌单资源
}