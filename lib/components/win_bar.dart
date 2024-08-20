import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_player/player.dart';
import 'package:menu_bar/menu_bar.dart';

class WinBar extends StatefulWidget {
  Widget child;

  WinBar({super.key, required this.child});

  @override
  State<WinBar> createState() => _WinBarState();
}

class _WinBarState extends State<WinBar> {
  VlcPlayer vlcPlayer = VlcPlayer.getInstance();

  @override
  Widget build(BuildContext context) {
    return MenuBarWidget(
      barStyle:
          MenuStyle(backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          return Colors.white;
        },
      ), shape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
        (states) {
          return const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          );
        },
      )),
      barButtons: [
        BarButton(
          text: const Text('File', style: TextStyle(color: Colors.black)),
          submenu: SubMenu(
            menuItems: [
              MenuButton(
                text: Text('Select File'),
                onTap: () async {
                  try {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            allowedExtensions: ['mp4'], type: FileType.custom);
                    if (result != null) {
                      vlcPlayer.open(result.files.single.path!);
                    }
                  } catch (e) {
                    // todo
                  }
                },
                icon: Icon(Icons.save),
                shortcutText: 'Ctrl+O',
              ),
              const MenuDivider(),
              MenuButton(
                text: Text('Exit'),
                onTap: () {
                  exit(0);
                },
                icon: Icon(Icons.exit_to_app),
                shortcutText: 'Ctrl+Q',
              ),
            ],
          ),
        ),
        BarButton(
          text: Text('Help', style: TextStyle(color: Colors.black)),
          submenu: SubMenu(
            menuItems: [
              MenuButton(
                text: Text('About'),
                onTap: () {},
                icon: Icon(Icons.info),
              ),
            ],
          ),
        ),
      ],

      // Set the child, i.e. the application under the menu bar
      child: widget.child,
    );
  }
}
