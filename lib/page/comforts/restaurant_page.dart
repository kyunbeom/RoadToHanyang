import 'package:flutter/material.dart';

import '../../map_sample.dart';

class Restaurant extends StatefulWidget {
  const Restaurant({Key? key}) : super(key: key);

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xff0E4A84),
            iconTheme: const IconThemeData(color: Colors.white),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Center(
                child: Text('식당', style: TextStyle(color: Colors.white))),
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
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 2,
                  trackVisibility: true,
                  scrollbarOrientation: ScrollbarOrientation.bottom,
                  controller: scrollController,
                  child: DataTable(
                      //columnSpacing: 10,
                      dataRowHeight: 70,
                      columns: const [
                        DataColumn(label: Text('식당명')),
                        DataColumn(label: Text('좌석수')),
                        DataColumn(label: Text('위치')),
                        DataColumn(label: Text('운영시간')),
                        DataColumn(label: Text('연락처')),
                      ],
                      rows: const [
                        DataRow(cells: [
                          DataCell(Text('학생식당')),
                          DataCell(Text('342')),
                          DataCell(Text('학생복지관 3F')),
                          DataCell(
                              Text('10:30～18:30\n(Break Time 15:00~16:00)')),
                          DataCell(Text('02) 2220-1883')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('행원파크식당')),
                          DataCell(Text('463')),
                          DataCell(Text('행원파크 B1F')),
                          DataCell(Text('11:30~18:50')),
                          DataCell(Text('02) 2290-2762')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('제1학생생활관식당\n(고시반식당)')),
                          DataCell(Text('183')),
                          DataCell(Text('제1학생생활관 1F')),
                          DataCell(Text(
                              '07:30～09:00 (조)\n12:00～13:30 (중)\n17:30～18:30 (석)')),
                          DataCell(Text('02) 2220-1865')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('제2학생생활관식당')),
                          DataCell(Text('220')),
                          DataCell(Text('제2학생생활관 1F')),
                          DataCell(Text(
                              '07:30～09:00 (조)\n12:00～13:30 (중)\n17:30～19:00 (석)')),
                          DataCell(Text('02) 2290-3410')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('생활과학관 식당')),
                          DataCell(Text('276')),
                          DataCell(Text('생활과학관 7F')),
                          DataCell(Text('11:30～14:00 (중)\n17:00～18:30 (석)')),
                          DataCell(Text('02) 2298-8797')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('신소재공학관 식당\n(룸:112)')),
                          DataCell(Text('395')),
                          DataCell(Text('신소재공학관 7F')),
                          DataCell(Text('11:30～13:30 (중)\n17:00～18:30 (석)')),
                          DataCell(Text('070-4651-2388')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('이십사절기 식당')),
                          DataCell(Text('144')),
                          DataCell(Text('한양종합기술연구원 6F (HIT)')),
                          DataCell(Text('11:00~21:00')),
                          DataCell(Text('02) 2220-4771~2')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('이십사절기 연회장')),
                          DataCell(Text('92')),
                          DataCell(Text('한양종합기술연구원 6F (HIT)')),
                          DataCell(Text('11:00~21:00')),
                          DataCell(Text('02) 2220-4771~2')),
                        ])
                      ]),
                ))));
  }
}
