import 'package:flutter/material.dart';

hamburger() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.grey,
          ),
          accountName: Text('김윤범'),
          accountEmail: Text('kyb@hanyang.ac.kr'),
          decoration: BoxDecoration(
            color: Color(0xff0E4A84),
          ),
        ),
        ListTile(
          leading: Icon(Icons.history),
          iconColor: Color(0xff0E4A84),
          focusColor: Color(0xff0E4A84),
          title: const Text('나의 기록'),
          onTap: () {
            //Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.mode),
          iconColor: Color(0xff0E4A84),
          focusColor: Color(0xff0E4A84),
          title: const Text('나의 제보'),
          onTap: () {
            //Navigator.pop(context);
          },
        )
      ],
    ),
  );
}
