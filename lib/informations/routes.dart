import 'package:flutter/material.dart';

class RouteInforms extends StatelessWidget {
  final RouteNumber;

  const RouteInforms({Key? key, required this.RouteNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (RouteNumber) {
      case 0:
        return Container();
      case 1:
        return const Column(
          children: [
            SizedBox(height: 23),
            Row(children: [
              Icon(Icons.location_on, color: Colors.blue, size: 30),
              SizedBox(width: 14),
              Text('IT/BT관 3층', style: TextStyle(fontSize: 18))
            ]),
            SizedBox(height: 23),
            Row(children: [
              Icon(Icons.north, size: 30),
              SizedBox(width: 14),
              Text('대운동장 엘레베이터까지 이동', style: TextStyle(fontSize: 14))
            ]),
            SizedBox(height: 23),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.elevator, size: 30),
              SizedBox(width: 14),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('엘레베이터 3', style: TextStyle(fontSize: 18)),
                Text('엘레베이터 3을 타고 지하로 이동', style: TextStyle(fontSize: 14)),
              ])
            ]),
            SizedBox(height: 23),
            Row(children: [
              Icon(Icons.north, size: 30),
              SizedBox(width: 14),
              Text('엘레베이터 1까지 지하내에서 이동', style: TextStyle(fontSize: 14))
            ]),
            SizedBox(height: 23),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.elevator, size: 30),
              SizedBox(width: 14),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('엘레베이터 1', style: TextStyle(fontSize: 18)),
                Text('엘레베이터 1을 타고 1층으로 이동', style: TextStyle(fontSize: 14))
              ])
            ]),
            SizedBox(height: 23),
            Row(children: [
              Icon(Icons.north, size: 30),
              SizedBox(width: 14),
              Text('제1공학관까지 이동', style: TextStyle(fontSize: 14))
            ]),
            SizedBox(height: 23),
            Row(children: [
              Icon(Icons.location_on, color: Colors.red, size: 30),
              SizedBox(width: 14),
              Text('제1공학관 3층', style: TextStyle(fontSize: 18))
            ])
          ],
        );
      case 2:
        return Column(children: [
          SizedBox(height: 23),
          Row(children: [
            Icon(Icons.location_on, color: Colors.blue, size: 30),
            SizedBox(width: 14),
            Text('IT/BT관 3층', style: TextStyle(fontSize: 18))
          ]),
          SizedBox(height: 23),
          Row(children: [
            Icon(Icons.north, size: 30),
            SizedBox(width: 14),
            Text('제3법학관까지 이동', style: TextStyle(fontSize: 14))
          ]),
          SizedBox(height: 23),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(Icons.elevator, size: 30),
            SizedBox(width: 14),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('제3법학관 엘레베이터', style: TextStyle(fontSize: 18)),
              Text('제3법학관 엘레베이터를 타고 \n4층으로 이동', style: TextStyle(fontSize: 14))
            ])
          ]),
          SizedBox(height: 23),
          Row(children: [
            Icon(Icons.north, size: 30),
            SizedBox(width: 14),
            Text('행원파크까지 이동', style: TextStyle(fontSize: 14))
          ]),
          SizedBox(height: 23),
          Row(children: [
            Icon(Icons.location_on, color: Colors.red, size: 30),
            SizedBox(width: 14),
            Text('행원파크', style: TextStyle(fontSize: 18))
          ])
        ]);
      case 3:
        return Column(
          children: [
            SizedBox(height: 23),
            Row(children: [
              Icon(Icons.location_on, color: Colors.blue, size: 30),
              SizedBox(width: 14),
              Text('애지문', style: TextStyle(fontSize: 18))
            ]),
            SizedBox(height: 23),
            Row(children: [
              Icon(Icons.north, size: 30),
              SizedBox(width: 14),
              Text('본관건물 왼쪽까지 이동', style: TextStyle(fontSize: 14))
            ]),
            SizedBox(height: 23),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.stairs, size: 30),
              SizedBox(width: 14),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('본관&한양플라자 사이 계단', style: TextStyle(fontSize: 18)),
                Text('본관&한양플라자 사이 계단 오르기', style: TextStyle(fontSize: 14))
              ])
            ]),
            SizedBox(height: 23),
            Row(children: [
              Icon(Icons.north, size: 30),
              SizedBox(width: 14),
              Text('사회과학관까지 이동', style: TextStyle(fontSize: 14))
            ]),
            SizedBox(height: 23),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.elevator, size: 30),
              SizedBox(width: 14),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('사회과학관 엘레베이터', style: TextStyle(fontSize: 18)),
                Text('사회과학관 엘레베이터를 타고 \n4층으로 이동', style: TextStyle(fontSize: 14))
              ])
            ]),
            SizedBox(height: 23),
            Row(children: [
              Icon(Icons.north, size: 30),
              SizedBox(width: 14),
              Text('인문관까지 이동', style: TextStyle(fontSize: 14))
            ]),
            SizedBox(height: 23),
            Row(children: [
              Icon(Icons.location_on, color: Colors.red, size: 30),
              SizedBox(width: 14),
              Text('인문관', style: TextStyle(fontSize: 18))
            ])
          ],
        );
      default:
        return Container();
    }
  }
}
