

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_player/app.dart';
import 'package:flutter_player/components/win_bar.dart';
import 'package:flutter_player/player.dart';
import 'package:menu_bar/menu_bar.dart';

void main() {
  VlcPlayer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      // home:const App(),
      home: WinBar(child: const App()),
    );
  }
}

