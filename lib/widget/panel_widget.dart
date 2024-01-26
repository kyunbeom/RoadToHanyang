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
            SizedBox(height: 12),
            buildDragHandle(),
            SizedBox(height: 15),
            buildAboutText(context),
            SizedBox(height: 46),
            Center(
                child: GestureDetector(
                    child: Container(
                        margin: EdgeInsets.only(bottom: 12),
                        width: MediaQuery.of(context).size.width - 24,
                        height: 43,
                        decoration: BoxDecoration(
                            color: Color(0xff0E4A84),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                            child: Text(
                          '문의',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ))),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InquiryBoard()));
                    }))
          ]);

  Widget buildAboutText(BuildContext context) => Container(
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
                '예상 소요시간 : ${routes[RouteNumber].time}분',
                style: TextStyle(color: Colors.black, fontSize: 24),
              )
            ]),
            SizedBox(height: 8),
            PathToggle(
                title: '경로 상세', content: routes[RouteNumber].routeInforms)
          ],
        ),
      );

  Widget buildDragHandle() => GestureDetector(
      child: Center(
          child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12)))),
      onTap: togglePanel);

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}
