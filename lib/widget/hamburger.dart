import 'package:flutter/material.dart';
import 'package:road_to_hanyang/page/comforts/convenience_page.dart';
import 'package:road_to_hanyang/page/comforts/etc_page.dart';
import 'package:road_to_hanyang/page/comforts/print_location_page.dart';
import 'package:road_to_hanyang/page/comforts/print_page.dart';
import 'package:road_to_hanyang/page/comforts/restaurant_page.dart';
import 'package:road_to_hanyang/page/inquiry_board.dart';
import 'package:road_to_hanyang/page/setting_page.dart';
import 'package:road_to_hanyang/page/weak_page.dart';

class Hamburger extends StatelessWidget {
  const Hamburger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color(0xff0E4A84),
        child: ListView(padding: EdgeInsets.only(top: 30), children: [
          // const UserAccountsDrawerHeader(
          //   currentAccountPicture: CircleAvatar(
          //     backgroundColor: Colors.grey,
          //   ),
          //   accountName: Text('김윤범'),
          //   accountEmail: Text('kyb@hanyang.ac.kr'),
          //   decoration: BoxDecoration(
          //     color: Color(0xff0E4A84),
          //   ),
          // ),
          ExpansionTile(
              backgroundColor: Colors.white,
              leading: Icon(Icons.lightbulb),
              iconColor: Color(0xff0E4A84),
              title: Text(
                '편의시설',
                style: TextStyle(fontSize: 15),
              ),
              textColor: Color(0xff0E4A84),
              collapsedBackgroundColor: Color(0xff0E4A84),
              collapsedIconColor: Colors.white,
              collapsedTextColor: Colors.white,
              children: [
                Container(
                    color: Color(0xff0E4A84).withOpacity(0.2),
                    child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(left: 70),
                        title: Row(children: [
                          Icon(Icons.print, size: 16, color: Colors.white),
                          SizedBox(width: 15),
                          Text('복사실')
                        ]),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Print2()));
                        })),
                Container(
                    color: Color(0xff0E4A84).withOpacity(0.2),
                    child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(left: 70),
                        title: Row(children: [
                          Icon(Icons.restaurant, size: 16, color: Colors.white),
                          SizedBox(width: 15),
                          Text('식당')
                        ]),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Restaurant()));
                        })),
                Container(
                    color: Color(0xff0E4A84).withOpacity(0.2),
                    child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(left: 70),
                        title: Row(children: [
                          Icon(Icons.local_cafe, size: 16, color: Colors.white),
                          SizedBox(width: 15),
                          Text('카페')
                        ]),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Restaurant()));
                        })),
                Container(
                    color: Color(0xff0E4A84).withOpacity(0.2),
                    child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(left: 70),
                        title: Row(children: [
                          Icon(Icons.local_convenience_store,
                              size: 16, color: Colors.white),
                          SizedBox(width: 15),
                          Text('편의점')
                        ]),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConvStore()));
                        })),
                Container(
                    color: Color(0xff0E4A84).withOpacity(0.2),
                    child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.only(left: 70),
                        title: Row(children: [
                          Icon(Icons.more, size: 16, color: Colors.white),
                          SizedBox(width: 15),
                          Text('기타')
                        ]),
                        textColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Others()));
                        }))
              ]),
          ListTile(
              leading: Icon(Icons.accessible_forward),
              iconColor: Colors.white,
              focusColor: Colors.white,
              title: const Text('교통약자지도'),
              textColor: Colors.white,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TransWeak()));
              }),
          ListTile(
              leading: Icon(Icons.mail),
              iconColor: Colors.white,
              focusColor: Colors.white,
              title: const Text('문의'),
              textColor: Colors.white,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InquiryBoard()));
              }),
          ListTile(
              leading: Icon(Icons.settings),
              iconColor: Colors.white,
              focusColor: Colors.white,
              title: const Text('설정'),
              textColor: Colors.white,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Setting()));
              })
        ]));
  }
}
