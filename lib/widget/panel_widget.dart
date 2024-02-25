import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:road_to_hanyang/page/inquiry_board.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../informations/locations.dart';
import '../page/how_to_page.dart';
import 'toggle.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  final int RouteNumber;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
    required this.RouteNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
          padding: EdgeInsets.zero,
          controller: controller,
          children: <Widget>[
            SizedBox(height: 10),
            buildDragHandle(),
            SizedBox(height: 10),
            buildAboutText(context),
          ]);

  Widget buildAboutText(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(
                Icons.watch_later_outlined,
                color: Color(0xff0E4A84),
                size: 20,
              ),
              SizedBox(width: 16),
              Text(
                '예상 소요시간',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 16),
              Text(
                '${routes[RouteNumber].time}분',
                style: TextStyle(
                    color: Color(0xff0E4A84),
                    fontSize: 26,
                    fontWeight: FontWeight.w600),
              )
            ]),
            SizedBox(height: 14),
            PathToggle(title: '경로상세', content: routes[RouteNumber].routeInforms)
          ],
        ),
      );

  Widget buildDragHandle() => GestureDetector(
      child: Center(
          child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5)))),
      onTap: togglePanel);

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}
