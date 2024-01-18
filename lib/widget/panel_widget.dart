import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:road_to_hanyang/page/report_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../page/how_to_page.dart';
import 'route_widget.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  final bool isPathPage;

  final int minute;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
    required this.isPathPage,
    required this.minute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
          padding: EdgeInsets.zero,
          controller: controller,
          children: <Widget>[
            SizedBox(height: 12),
            buildDragHandle(),
            SizedBox(height: 20),
            buildAboutText(context),
            SizedBox(
              height: 24,
            )
          ]);

  Widget buildAboutText(BuildContext context) => isPathPage
      ? RouteDetails(
          minute: minute,
        )
      : Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.5 - 36,
                    height: 43,
                    decoration: BoxDecoration(
                        color: Color(0xff0E4A84),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: Text(
                      '사용 방법',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ))),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HowToPage()));
                }),
            SizedBox(width: 24),
            GestureDetector(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.5 - 36,
                    height: 43,
                    decoration: BoxDecoration(
                        color: Color(0xff0E4A84),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: Text('문의',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600)))),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReportPage()));
                }),
          ]));

  Widget buildDragHandle() => GestureDetector(
      child: Center(
          child: Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12)))),
      onTap: togglePanel);

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}
