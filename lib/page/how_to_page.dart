import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../map_sample.dart';

class HowToPage extends StatelessWidget {
  const HowToPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff0E4A84),
          iconTheme: IconThemeData(color: Colors.white),
          title: Center(
              child: Text('사용방법', style: TextStyle(color: Colors.white))),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MapSample()),
                    (route) => false, // 모든 이전 화면 흔적을 제거
                  );
                })
          ]),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('공통'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('언어'),
                value: Text('한국어'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: Icon(Icons.format_paint),
                title: Text('Enable custom theme'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
