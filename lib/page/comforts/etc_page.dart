import 'package:flutter/material.dart';

import '../../screen/map_sample.dart';

class Others extends StatelessWidget {
  const Others({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xff0E4A84),
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Center(
                child:
                    Text('기타 복지편의시설', style: TextStyle(color: Colors.white))),
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
        body: Center(
            child: DataTable(columns: const [
          DataColumn(label: Text('매장명')),
          DataColumn(label: Text('위치')),
          DataColumn(label: Text('연락처')),
        ], rows: const [
          DataRow(cells: [
            DataCell(Text('역사관 기념품점')),
            DataCell(Text('역사관 1F')),
            DataCell(Text('02) 2220-4141')),
          ]),
          DataRow(cells: [
            DataCell(Text('구두수선센타')),
            DataCell(Text('학생회관 앞')),
            DataCell(Text('02) 2220-1867')),
          ]),
          DataRow(cells: [
            DataCell(Text('문구점')),
            DataCell(Text('학생회관 B1F')),
            DataCell(Text('02) 2296-9500')),
          ]),
          DataRow(cells: [
            DataCell(Text('서 점')),
            DataCell(Text('학생회관 B1F')),
            DataCell(Text('02) 2220-1851')),
          ]),
          DataRow(cells: [
            DataCell(Text('미용실')),
            DataCell(Text('학생회관 1F')),
            DataCell(Text('02) 2220-1554')),
          ]),
          DataRow(cells: [
            DataCell(Text('Book 카페')),
            DataCell(Text('학생회관 1F')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('휘트니스센터')),
            DataCell(Text('학생회관 5F')),
            DataCell(Text('02) 2299-9688')),
          ])
        ])));
  }
}
