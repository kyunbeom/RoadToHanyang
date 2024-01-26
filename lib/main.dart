import 'package:flutter/material.dart';
import 'package:road_to_hanyang/screen/splash_screen.dart';
import 'screen/map_sample.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
