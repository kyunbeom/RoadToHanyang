import 'package:flutter/material.dart';

class StopwatchApp extends StatefulWidget {
  @override
  _StopwatchAppState createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {
  final Stopwatch _stopwatch = Stopwatch();
  late final Duration _refreshRate;
  late final ValueNotifier<String> _timeDisplay;
  bool isRun = false;

  @override
  void initState() {
    super.initState();
    _refreshRate = Duration(milliseconds: 100); // 업데이트 주기
    _timeDisplay = ValueNotifier("00:00");
    _stopStopwatch();

  }

  void _startStopwatch() {
    _stopwatch.start();
    setState(() {
      isRun = true;
    });
    _updateTime();
  }

  void _updateTime() {
    if (isRun) {
      Future.delayed(_refreshRate, _updateTime);
    }
    int milliseconds = _stopwatch.elapsedMilliseconds;
    int seconds = (milliseconds / 1000).floor();
    int minutes = (seconds / 60).floor();
    seconds %= 60;
    minutes %= 60;
    String formattedTime =
        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    _timeDisplay.value = formattedTime;
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    setState(() {
      isRun = false;
    });
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    _timeDisplay.value = "00:00";
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 80.0, left: 250),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: _timeDisplay,
              builder: (context, value, child) {
                return Text(
                  value,
                  style: TextStyle(fontSize: 48),
                );
              },
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0E4A84),
                      padding: EdgeInsets.all(25.0),
                      //textStyle: TextStyle(color: Colors.white, fontSize: 23.0),
                      shape: CircleBorder()),
                  onPressed: isRun ? _stopStopwatch : _startStopwatch,
                  child: Text(isRun ? 'Stop' : 'Start'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0E4A84),
                      padding: EdgeInsets.all(25.0),
                      //textStyle: TextStyle(color: Colors.white, fontSize: 23.0),
                      shape: CircleBorder()),
                  onPressed: _resetStopwatch,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
