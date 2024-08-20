import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_player/player.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  VlcPlayer vlcPlayer = VlcPlayer.getInstance();

  @override
  void initState() {
    super.initState();
    vlcPlayer.open('E:/aDriver/test.mp4');
  }

  @override
  void dispose() {
    vlcPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Video(
            player: vlcPlayer.instance,
            height: double.infinity,
            width: double.infinity,
            scale: 1.0,
            showControls: true, // default
          )
        ],
      ),
    );
  }
}
