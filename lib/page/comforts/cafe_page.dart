import 'package:flutter/material.dart';

import '../../screen/map_sample.dart';

class Cafe extends StatelessWidget {
  const Cafe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xff0E4A84),
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Center(
                child: Text('카페', style: TextStyle(color: Colors.white))),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MapSample()),
                      (route) => false, // 모든 이전 화면 흔적을 제거
                    );
                  })
            ]),
        body: Column(children: [
          Center(
              child: DataTable(columns: const [
            DataColumn(label: Text('건물명')),
            DataColumn(label: Text('위치')),
            DataColumn(label: Text('연락처')),
          ], rows: const [
            DataRow(cells: [
              DataCell(Text('카페 ING')),
              DataCell(Text('인문관 B1F')),
              DataCell(Text('')),
            ]),
            DataRow(cells: [
              DataCell(Text('띠아모카페')),
              DataCell(Text('학술정보관앞')),
              DataCell(Text('02) 2298-8901')),
            ]),
            DataRow(cells: [
              DataCell(Text('팬도로시 카페')),
              DataCell(Text('과학기술관 1F')),
              DataCell(Text('')),
            ]),
            DataRow(cells: [
              DataCell(Text('블루포트')),
              DataCell(Text('FTC관 3F')),
              DataCell(Text('070-4755-1122')),
            ]),
            DataRow(cells: [
              DataCell(Text('카페 큐')),
              DataCell(Text('IT/BT관 3F')),
              DataCell(Text('02) 2294-0222')),
            ]),
            DataRow(cells: [
              DataCell(Text('딕 셔너리 카페')),
              DataCell(Text('간호학부 미래교육관 1F')),
              DataCell(Text('')),
            ])
          ])),
          Container()
        ]));
  }
}
