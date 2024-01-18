import 'package:flutter/material.dart';

import '../map_sample.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff0E4A84),
          title: Center(child: Text('문의')),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => MapSample()));
                  // Navigator.popUntil(context, (route) => route.isFirst);
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
