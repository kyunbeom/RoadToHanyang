import 'package:flutter/material.dart';
import 'package:road_to_hanyang/toggle.dart';

class RouteDetails extends StatelessWidget {
  final int minute;

  const RouteDetails({
    Key? key,
    required this.minute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(
              Icons.directions_walk,
              color: Colors.black,
              size: 30,
            ),
            SizedBox(width: 10),
            Text(
              '예상 소요시간 : $minute분',
              style: TextStyle(color: Colors.black, fontSize: 24),
            )
          ]),
          SizedBox(height: 20),
          PathToggle(
              title: '경로 상세',
              content: Text(
                'IT/BT관 출발\n대운동장 엘베\n지하주차장\n올라가랇ㅁ\n도차꾸\ny\nu\ni\no\nnp\na\ns\nd\nf\ng\nh\nj\nk\nl\nz\nx\nc\nc\nv\nb\nn\nm',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ))
        ],
      ),
    );
  }
}
