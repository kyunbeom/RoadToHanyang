import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:road_to_hanyang/firebase_options.dart';
import 'package:road_to_hanyang/screen/splash_screen.dart';
import 'screen/map_sample.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
