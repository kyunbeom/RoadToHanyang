import 'package:flutter/material.dart';

import '../map_sample.dart';

class TransWeak extends StatelessWidget {
  const TransWeak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff0E4A84),
          iconTheme: IconThemeData(color: Colors.white),
          title:
          Center(child: Text('교통약자지도', style: TextStyle(color: Colors.white))),
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
      body: Center(),
    );
  }
}
