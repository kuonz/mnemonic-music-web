import 'package:flutter/material.dart';
import 'package:mnemonic_music_web/model/music_model.dart';

class SongListProvider with ChangeNotifier {

  // 状态
  bool _canSelect;
  bool _canAddToSet;
  Set<int> _indexSet;
  List<MusicModel> _list;

  // 初始化
  SongListProvider() {
    _canSelect = false;
    _canAddToSet = false;
    _indexSet = new Set<int>();

    _list = List<MusicModel>();
    for (int i=1; i<6; i++) {
      _list.add(MusicModel(
        uuid: "song-poiuytrewq" + i.toString(), 
        name: "foo" + i.toString(), 
        singer: "foo-singer-" + i.toString(), 
        length: "4:37", 
        url: "http://127.0.0.1:53927/static/foo" + i.toString() + ".mp3"
      ));
    }
  }

  // 获取
  bool get canSelect => _canSelect;
  bool get canAddToSet => _canAddToSet;
  Set<int> get indexSet => _indexSet;
  List<MusicModel> get list => _list;

  // 更新
  _setCanSelect(bool b) {
    _canSelect = b;
    notifyListeners();
  }
  set canSelect(bool b) => _setCanSelect(b);

  _setCanAddToSet(bool b) {
    _canAddToSet = b;
    notifyListeners();
  }
  set canAddToSet(bool b) => _setCanAddToSet(b);

  indexSetAdd(int value) {
    _indexSet.add(value);
    notifyListeners();
  }

  indexSetRemove(int value) {
    _indexSet.remove(value);
    notifyListeners();
  }

  bool indexSetContains(int value) => _indexSet.contains(value);

  indexSetClear() {
    _indexSet.clear();
    notifyListeners();
  }
}