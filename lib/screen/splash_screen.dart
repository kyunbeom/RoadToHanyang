import 'package:flutter/material.dart';
import 'package:road_to_hanyang/screen/map_result.dart';
import 'package:road_to_hanyang/screen/map_sample.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 일정 시간이 지난 후에 메인 화면으로 이동
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MapSample()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff), // 배경색 설정
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //SizedBox(height: 75),
            Image.asset(
              'assets/길냥로고.png',
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            const Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: ' 길',
                      style: TextStyle(fontSize: 30, color: Colors.black)),
                  TextSpan(
                      text: '잃은 ',
                      style: TextStyle(fontSize: 18, color: Color(0xff0E4A84))),
                  TextSpan(
                      text: '냥',
                      style: TextStyle(fontSize: 30, color: Colors.black)),
                  TextSpan(
                      text: '대생들 ',
                      style: TextStyle(fontSize: 18, color: Color(0xff0E4A84))),
                  TextSpan(
                      text: '이',
                      style: TextStyle(fontSize: 30, color: Colors.black)),
                  TextSpan(
                      text: '리오세요 ',
                      style: TextStyle(fontSize: 18, color: Color(0xff0E4A84))),
                ],
              ),
            )

            /* Text(
            '길 냥 이',
            style: TextStyle(fontFamily: 'newFont1', fontSize: 30, color: Colors.blueAccent, fontWeight: FontWeight.bold, ),
          ),*/
          ],
        ),
        // 스플래시 화면 이미지 설정
      ),
    );
  }
}
