import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:events_emitter/events_emitter.dart';

class PlayerEvents {
  // 私有构造函数，确保无法直接实例化
  PlayerEvents._internal();

  static String DurationChange = 'durationChange';
  static String PositionChange = 'positionChange';
  static String Play='play';
  static String Pause='pause';
}

class VlcPlayer {
  static init() {
    DartVLC.initialize();
  }

  //  单例模式，将一个类的构造函数设置为私有，并提供一个静态公有方法来创建和返回类的实例。
//  这确保了全局只有一个实例，并提供了一个访问该实例的全局点
  static final VlcPlayer _player = VlcPlayer._internal();

//获取实例
  static getInstance() {
    return _player;
  }

  factory VlcPlayer() {
    return _player;
  }

  // 私有构造函数，确保外部无法直接实例化
  VlcPlayer._internal() {
    _initListener();
  }

  final EventEmitter events = EventEmitter();

  Player instance = Player(id: 1);

  Duration duration = Duration.zero;

  Duration position = Duration.zero;
//  是否已经完成播放
  bool isCompleted = false;
//  是否正在播放
  bool isPlaying = false;

  PlaybackState playback = PlaybackState();

  _onPositionChange(PositionState value) {
    if (value.duration != duration) {
      duration = value.duration ?? Duration.zero;
      emit(PlayerEvents.DurationChange, duration);
    }
    if (value.position != position) {
      position = value.position ?? Duration.zero;
      emit(PlayerEvents.PositionChange, position);
    }
  }

  _onPlaybackChange(PlaybackState value) {
    if(value.isCompleted!=isCompleted){
      isCompleted = value.isCompleted;
    }

    if(value.isPlaying!=isPlaying){
      if(value.isPlaying){
        emit(PlayerEvents.Play);
      }else{
        emit(PlayerEvents.Pause);
      }
      isPlaying = value.isPlaying;
    }

  }

//  注册事件监听
  _initListener() {
    instance.positionStream.listen(_onPositionChange);
    instance.playbackStream.listen(_onPlaybackChange);

    instance.currentStream.listen((value) {});

    instance.generalStream.listen((value) {});
    instance.videoDimensionsStream.listen((value) {});
    instance.bufferingProgressStream.listen(
      (value) {},
    );
  }

//  打开视频地址
  open(String filePath) {
    instance.open(
      Media.file(File(filePath)),
      autoStart: true, // default
    );
  }

//  事件监听
  on<T>(String eventName, dynamic Function(T data) action) {
    events.on(eventName, action);
    return this;
  }

// 事件触发
  emit(String eventName, [dynamic data]) {
    events.emit(eventName, data);
    return this;
  }

//  事件移除
  off(String eventName, dynamic Function(dynamic data)? action) {
    events.off(type: eventName, callback: action);
    return this;
  }

//  监听一次
  once(String eventName, dynamic Function(dynamic data) action) {
    events.once(eventName, action);
    return this;
  }

//  销毁
  dispose() {
    instance.dispose();
    events.off();
  }
}
