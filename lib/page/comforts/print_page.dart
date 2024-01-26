import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../screen/map_sample.dart';

class Print extends StatelessWidget {
  const Print({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xff0E4A84),
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Center(
                child: Text('복사실', style: TextStyle(color: Colors.white))),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: const Icon(Icons.home),
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
        body: Column(children: [
          Center(
              child: DataTable(
                  columns: const [
                DataColumn(label: Text('건물명')),
                DataColumn(label: Text('위치')),
                DataColumn(label: Text('연락처'))
              ],
                  //columnSpacing: (MediaQuery.of(context).size.width - 30) * 0.33,
                  //dividerThickness: 3,
                  rows: const [
                DataRow(cells: [
                  DataCell(Text('학생복지관')),
                  DataCell(Text('1F')),
                  DataCell(Text('02) 2220-4700')),
                ]),
                DataRow(cells: [
                  DataCell(Text('경제금융관')),
                  DataCell(Text('B1F')),
                  DataCell(Text('02) 2291-1726')),
                ]),
                DataRow(cells: [
                  DataCell(Text('학술정보관')),
                  DataCell(Text('B1F')),
                  DataCell(Text('02) 2298-2041')),
                ]),
                DataRow(cells: [
                  DataCell(Text('공업센터')),
                  DataCell(Text('3F')),
                  DataCell(Text('02) 2295-5746')),
                ]),
                DataRow(cells: [
                  DataCell(Text('제1공학관')),
                  DataCell(Text('1F')),
                  DataCell(Text('02) 2220-1555')),
                ]),
                DataRow(cells: [
                  DataCell(Text('의대계단강의실')),
                  DataCell(Text('2F')),
                  DataCell(Text('02) 2296-0730')),
                ]),
                DataRow(cells: [
                  DataCell(Text('인문관')),
                  DataCell(Text('B1F')),
                  DataCell(Text('02) 2293-9598')),
                ]),
                DataRow(cells: [
                  DataCell(Text('신소재복사출력센터')),
                  DataCell(Text('B1F')),
                  DataCell(Text('02) 2296-2049')),
                ]),
                DataRow(cells: [
                  DataCell(Text('의과대학 본관')),
                  DataCell(Text('3F')),
                  DataCell(Text('02) 2295-2076')),
                ]),
                DataRow(cells: [
                  DataCell(Text('IT/BT관')),
                  DataCell(Text('1F')),
                  DataCell(Text('02) 2297-2049')),
                ])
              ])),
          // Center(
          //     child: RichText(
          //         text: TextSpan(
          //             text: '이것은 하이퍼링크 텍스트입니다. ',
          //             style: DefaultTextStyle.of(context).style,
          //             children: <TextSpan>[
          //       TextSpan(
          //           text: '클릭하면 어떤 동작을 수행하도록 할 수 있습니다.',
          //           style: TextStyle(
          //             color: Colors.blue,
          //             decoration: TextDecoration.underline,
          //           ),
          //           recognizer: TapGestureRecognizer()
          //             ..onTap = () {
          //               // 특정 동작을 수행할 함수 호출
          //               print('하이퍼링크가 클릭되었습니다.');
          //             })
          //     ])))
        ]));
  }
}
