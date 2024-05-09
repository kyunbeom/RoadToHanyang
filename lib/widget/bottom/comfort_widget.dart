import 'package:flutter/material.dart';
import 'package:road_to_hanyang/page/comforts/cafe_location_page.dart';
import 'package:road_to_hanyang/page/comforts/convenience_location_page.dart';
import 'package:road_to_hanyang/page/comforts/etc_location_page.dart';
import 'package:road_to_hanyang/page/comforts/print_location_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../page/comforts/restaurant_location_page.dart';

class ComfortWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController bottomController;

  const ComfortWidget(
      {Key? key, required this.controller, required this.bottomController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.zero,
        controller: controller,
        children: <Widget>[
          SizedBox(height: 10),
          buildDragHandle(),
          SizedBox(height: 10),
          buildAboutText(context),
        ]);
  }

//TODO: 알맞게 페이지 잊기
  Widget buildAboutText(BuildContext context) => Container(
        //TODO: 간격
        padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width - 332) * 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Print2())); // 복사실
                  },
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text('복사실', style: TextStyle(fontFamily: 'Pretendard' , fontSize: 12)),
                      ),
                    width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xffD9D9D9), width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(image: AssetImage('assets/icons/복사실.png')),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, 1)), // 광원: 위
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, -1)), // 광원: 아래
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(1, 0)), // 광원: 오른
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(-1, 0)) // 광원: 왼
                          ]),
                  )
              ),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Eat2())); // 식당
                  },
                  child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('식당', style: TextStyle(fontFamily: 'Pretendard' , fontSize: 12)),
                      ),
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xffD9D9D9), width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(image: AssetImage('assets/icons/식당.png')),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, 1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, -1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(1, 0)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(-1, 0))
                          ]))),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Convenience2()));
                  },
                  child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('편의점', style: TextStyle(fontFamily: 'Pretendard' , fontSize: 12)),
                      ),
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xffD9D9D9), width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(image: AssetImage('assets/icons/편의점.png')),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, 1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, -1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(1, 0)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(-1, 0))
                          ]))),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Others2()));
                  },
                  child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('기타', style: TextStyle(fontFamily: 'Pretendard' , fontSize: 12)),
                      ),
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xffD9D9D9), width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(image: AssetImage('assets/icons/기타.png')
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, 1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, -1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(1, 0)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(-1, 0))
                          ]))
              )
            ]),
            SizedBox(height: 4),
            Row(children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cafe2()));
                  },
                  child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('카페', style: TextStyle(fontFamily: 'Pretendard' , fontSize: 12)),
                      ),
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xffD9D9D9), width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(image: AssetImage('assets/icons/카페임시.png'),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, 1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, -1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(1, 0)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(-1, 0))
                          ]))),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Print2()));
                  },
                  child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text('ATM', style: TextStyle(fontFamily: 'Pretendard' , fontSize: 12)),
                      ),
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xffD9D9D9), width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(image: AssetImage('assets/icons/ATM.png'),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, 1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, -1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(1, 0)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(-1, 0))
                          ]))),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Print2()));
                  },
                  child: Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xffD9D9D9), width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, 1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, -1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(1, 0)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(-1, 0))
                          ]))),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Print2()));
                  },
                  child: Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Color(0xffD9D9D9), width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, 1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(0, -1)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(1, 0)),
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(-1, 0))
                          ])))
            ]),
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

  void togglePanel() => bottomController.isPanelOpen
      ? bottomController.close()
      : bottomController.open();
}
