import 'package:flutter/material.dart';
import 'package:road_to_hanyang/map_sample.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
void initState() {
  super.initState();
  // 일정 시간이 지난 후에 메인 화면으로 이동
  Future.delayed(Duration(seconds: 3), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MapSample()),
    );
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xffffffff),  // 배경색 설정
    body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Image.asset('assets/splash.png'),
          ),
          Text(
            '길냥이',
            style: TextStyle(fontFamily: 'newFont', fontSize: 24, color: Colors.blueAccent, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      // 스플래시 화면 이미지 설정
    ),
  );
}
}
