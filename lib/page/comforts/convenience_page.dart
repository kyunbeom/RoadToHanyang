import 'package:flutter/material.dart';

import '../../map_sample.dart';

class ConvStore extends StatelessWidget {
  const ConvStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff0E4A84),
            title: Center(child: Text('편의점')),
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
        body: Center(
            child: DataTable(columns: [
          DataColumn(label: Text('건물명')),
          DataColumn(label: Text('위치')),
          DataColumn(label: Text('연락처')),
        ], rows: [
          DataRow(cells: [
            DataCell(Text('신소재공학관편의점\n(세븐일레븐)')),
            DataCell(Text('B1F')),
            DataCell(Text('1577-07111')),
          ]),
          DataRow(cells: [
            DataCell(Text('사자가군것질할때\n편의점(세븐일레븐)')),
            DataCell(Text('학술정보관앞')),
            DataCell(Text('1577-0711')),
          ]),
          DataRow(cells: [
            DataCell(Text('제1학생생활관\n편의점(CU)')),
            DataCell(Text('1F')),
            DataCell(Text('02) 2293-6105')),
          ]),
          DataRow(cells: [
            DataCell(Text('인문관 편의점\n(이마트24)')),
            DataCell(Text('B1F')),
            DataCell(Text('02) 2297-6577')),
          ]),
          DataRow(cells: [
            DataCell(Text('제2학생생활관\n편의점(CU)')),
            DataCell(Text('1F')),
            DataCell(Text('02) 2281-5715')),
          ])
        ])));
  }
}
