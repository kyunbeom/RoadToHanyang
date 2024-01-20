import 'package:flutter/material.dart';
import 'package:road_to_hanyang/toggle.dart';

import '../informations/locations.dart';

class RouteDetails extends StatefulWidget {
  const RouteDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<RouteDetails> createState() => _RouteDetailsState();
}

class _RouteDetailsState extends State<RouteDetails> {
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
              '예상 소요시간 : ${routes[1].time}분',
              style: TextStyle(color: Colors.black, fontSize: 24),
            )
          ]),
          SizedBox(height: 8),
          PathToggle(title: '경로 상세', content: routes[1].routeInforms)
        ],
      ),
    );
  }
}
