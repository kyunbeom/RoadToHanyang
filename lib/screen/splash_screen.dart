import 'package:flutter/material.dart';
import 'package:road_to_hanyang/screen/map_result.dart';
import 'package:road_to_hanyang/screen/map_sample.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  List<String> imageUrls = [
    'assets/길냥로고.png',
    'assets/길냥로고.png',
    'assets/스플래시눈감은고앵.png',
    'assets/스플래시눈반뜬고앵.png',
    'assets/스플래시눈뜬고양이.png',
  ];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    displayNextImage();

    // animationController.forward();
    //
    // animationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => MapSample()),
    //     );
    //   }
    // });
    // 일정 시간이 지난 후에 메인 화면으로 이동
    // Future.delayed(Duration(seconds: 1), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => MapSample()),
    //   );
    // });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void displayNextImage() {
    if (currentIndex >= imageUrls.length - 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MapSample()));
      return;
    }
    animationController.duration =
        Duration(milliseconds: getImageDuration(currentIndex));
    animationController.forward().then((_) {
      Future.delayed(Duration(milliseconds: 1), () {
        setState(() {
          currentIndex++;
          animationController.reset();
          displayNextImage();
        });
      });
    });
  }

  int getImageDuration(int index) {
    switch (index) {
      case 0:
        return 1500;
      case 1:
        return 10;
      case 2:
        return 1000;
      case 3:
        return 10;
      default:
        return 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0E4A84),
      body: Center(
        child: FadeTransition(
          opacity: animationController,
          child: Image.asset(
            imageUrls[currentIndex],
            width: 200,
            height: 200,
          ),
        ),
      ),

      // body: Center(
      //   child: FadeTransition(
      //     opacity: animationController.drive(TweenSequence([
      //       TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 1.5),
      //       TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 0.01),
      //       TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 1),
      //       TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 0.01),
      //     ])),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         SvgPicture.asset(
      //           'assets/splash/눈뜬고양이.svg',
      //           width: 190,
      //           height: 190,
      //         ),
      //       ],
      //     ),
      //   ),
      // ), // 배경색 설정
      // // body: Container(
      // //   width: MediaQuery.of(context).size.width,
      // //   height: MediaQuery.of(context).size.height,
      // //   child: Column(
      // //     crossAxisAlignment: CrossAxisAlignment.center,
      // //     mainAxisAlignment: MainAxisAlignment.center,
      // //     children: <Widget>[
      // //       //SizedBox(height: 75),
      // //       Image.asset(
      // //         'assets/길냥로고.png',
      // //         width: MediaQuery.of(context).size.width * 0.3,
      // //         height: MediaQuery.of(context).size.height * 0.3,
      // //       ),
      // //       const Text.rich(
      // //         TextSpan(
      // //           children: <TextSpan>[
      // //             TextSpan(
      // //                 text: ' 길',
      // //                 style: TextStyle(fontSize: 30, color: Colors.black)),
      // //             TextSpan(
      // //                 text: '잃은 ',
      // //                 style: TextStyle(fontSize: 18, color: Color(0xff0E4A84))),
      // //             TextSpan(
      // //                 text: '냥',
      // //                 style: TextStyle(fontSize: 30, color: Colors.black)),
      // //             TextSpan(
      // //                 text: '대생들 ',
      // //                 style: TextStyle(fontSize: 18, color: Color(0xff0E4A84))),
      // //             TextSpan(
      // //                 text: '이',
      // //                 style: TextStyle(fontSize: 30, color: Colors.black)),
      // //             TextSpan(
      // //                 text: '리오세요 ',
      // //                 style: TextStyle(fontSize: 18, color: Color(0xff0E4A84))),
      // //           ],
      // //         ),
      // //       )
      // //
      // //       /* Text(
      // //       '길 냥 이',
      // //       style: TextStyle(fontFamily: 'newFont1', fontSize: 30, color: Colors.blueAccent, fontWeight: FontWeight.bold, ),
      // //     ),*/
      // //     ],
      // //   ),
      // //   // 스플래시 화면 이미지 설정
      // // ),
    );
  }
}
/*
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

 Text(
            '길 냥 이',
            style: TextStyle(fontFamily: 'newFont1', fontSize: 30, color: Colors.blueAccent, fontWeight: FontWeight.bold, ),
          ),

          ],
        ),
        // 스플래시 화면 이미지 설정
      ),
    );
  }
}
*/
