import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mnemonic_music_web/model/music_model.dart';
import 'package:mnemonic_music_web/utils/storage.dart';

class PlayerProvider with ChangeNotifier {

  /* 状态 */
  AudioPlayer _player; // 播放器单例对象
  int _currentPlayIndex; // 当前播放下标,-1代表播放列表为空
  bool _playing; // 是否正在播放
  int _volume; // 音量
  int _modeIndex; // 播放模式
  List<MusicModel> _playlist; // 播放列表
  bool _enable; // 资源是否获取成功
  bool _failed; // 资源是否获取失败
  bool _loading; // 资源是否正在获取

  /* 初始化 */
  PlayerProvider() {
    _player = AudioPlayer();
    _currentPlayIndex = -1;
    _playing = false;
    _volume = 5;
    _modeIndex = 0;
    _playlist = new List<MusicModel>();
    _enable = false;
    _failed = false;
    _loading = false;
  }

  /* 获取状态 */
  AudioPlayer get player => _player;
  bool get playing => _playing;
  int get volume => _volume;
  int get modeIndex => _modeIndex;
  List<MusicModel> get playlist => _playlist;
  bool get enable => _enable;
  bool get failed => _failed;
  bool get loading => _loading;

  /* 设置状态 */
  //-- enable设置 --//
  _setEnable(bool enable) {
    _enable = enable;
    notifyListeners();
  }
  //-- failed设置 --//
  _setFailed(bool failed) {
    _failed = failed;
    notifyListeners();
  }
  //-- loading设置 --//
  _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
  //-- player设置 --//
  Future<bool> _initResource() async { // 获取资源
    return await _player.setUrl(_playlist[_currentPlayIndex].url)
      .timeout(Duration(seconds: 5))
      .then((value) {
        _setEnable(true);
        _setLoading(false);
        return true; 
      })
      .catchError((error) {
        _setFailed(true);
        _setLoading(false);
        return false;
      });
  }
  _resetPlayer() {
    var temp = _player;
    _player = new AudioPlayer();
    _player.setVolume(_volume / 10);
    temp.dispose().then((value) {
      _setLoading(true);
      _setEnable(false);
      _setFailed(false);
    });
  }
  //-- 是否正在播放设置 --//
  _setPlaying(bool playing) {
    _playing = playing;
    notifyListeners();
  }
  //-- 音量设置 --//
  _setVolumeAndNotify(int volume) {
    _volume = volume;
    notifyListeners();
    Storage.setInt("volume", volume);
  }
  _setVolume(int volume) {
     _volume = volume;
  }
  set volume(int volume) => _setVolumeAndNotify(volume);
  set volumeInit(int volume) => _setVolume(volume);
  //-- 播放模式设置 --//
  _setModeIndexAndNotify(int modeIndex) {
    _modeIndex = modeIndex;
    notifyListeners();
    Storage.setInt("modeIndex", modeIndex);
  }
  _setModeIndex(int modeIndex) {
    _modeIndex = modeIndex;
  }
  set modeIndex(int modeIndex) => _setModeIndexAndNotify(modeIndex);
  set modeIndexInit(int modeIndex) => _setModeIndex(modeIndex);
  //-- 播放列表设置 --//
  _playlistStorage() {
    String _json = json.encode(_playlist);
    Storage.setString("playlist", _json);
  }
  playlistJsonDecode(List<dynamic> list) {
    list.forEach((element) {
      _playlist.add(MusicModel.fromJson(element));
    });
  }
  playlistHeadAdd(MusicModel item) {
    _playlist.insert(0, item);
    notifyListeners();
    _playlistStorage();

    _currentPlayIndex = 0;
    _resetPlayer();
    _initResource().then((value) {
      if (value) {
        _player.play();
        _setPlaying(true);
      }
    });
  }
  playlistAppend(MusicModel item) {
    _playlist.add(item);
    if (_currentPlayIndex == -1) {
      _currentPlayIndex = 0;
      _initResource();
    }
  }
  playlistNotify() {
    notifyListeners();
    _playlistStorage();
  }
  int playlistContains(MusicModel item) {
    for (int i=0; i<_playlist.length; i++) {
      if (item.url == _playlist[i].url) {
        return i;
      }
    }
    return -1;
  }
  MusicModel playlistRemoveAt(int index) {
    if (_currentPlayIndex == index) {
      _setPlaying(false);
      _currentPlayIndex = _currentPlayIndex % playlist.length;
      _resetPlayer();
      _initResource();
    } else if (index < _currentPlayIndex) {
      _currentPlayIndex--;
    }

    MusicModel item = _playlist.removeAt(index);
    notifyListeners();
    _playlistStorage();

    if (_playlist.length <= 0) {
      _currentPlayIndex = -1;
    }

    return item;
  }
  playlistClear() {
    _currentPlayIndex = -1;
    _resetPlayer();
    _setPlaying(false);
    _playlist.clear();
    notifyListeners();
    _playlistStorage();
  }

  /* 播放控制 */
  play(BuildContext context) {
    _player.play();
    _setPlaying(true);
  }
  pause() {
    _player.pause();
    _setPlaying(false);
  }
  previous(BuildContext context) {
    if (_currentPlayIndex > 0) {
      _currentPlayIndex--;
    } else if (_currentPlayIndex == 0) {
      _currentPlayIndex = _playlist.length - 1;
    }
    _resetPlayer();
    _initResource().then((value) {
      if(value) {
        _player.play();
        _setPlaying(true);
      }
    });
  }
  next() {
    _currentPlayIndex = (_currentPlayIndex + 1) % _playlist.length;
    _resetPlayer();
    _initResource().then((value) { 
      if (value) {
        _player.play();
        _setPlaying(true);
      }
    });
  }
  repeat() {
    _resetPlayer();
    _initResource().then((value) { 
      if (value) {
        _player.play();
        _setPlaying(true);
      }
    });
  }
  playAtIndex(int targetIndex) {
    _currentPlayIndex = targetIndex;
    _resetPlayer();
    _initResource().then((value) {
      if (value) {
        _player.play();
        _setPlaying(true);
      }
    });
  }
  MusicModel get currentPlayingItem {
    if (_currentPlayIndex < 0) {
      return MusicModel.empty();
    }
    return _playlist[_currentPlayIndex];
  }
}