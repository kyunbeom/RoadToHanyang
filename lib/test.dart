import 'package:flutter/material.dart';
import 'package:road_to_hanyang/bottomsheet.dart';
import 'package:road_to_hanyang/hamburger.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key, required String title}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      endDrawer: hamburger(),
    );
  }
}
