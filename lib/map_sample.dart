import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_to_hanyang/info.dart';
import 'package:road_to_hanyang/report.dart';
import 'package:road_to_hanyang/toggle.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'hamburger.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  PanelController _pc = new PanelController();

  final Stopwatch _stopwatch = Stopwatch();
  late final Duration _refreshRate;
  late final ValueNotifier<String> _timeDisplay;
  bool isRun = false;
  bool isClock = false;

  @override
  void initState() {
    super.initState();
    _refreshRate = Duration(milliseconds: 100); // 업데이트 주기
    _timeDisplay = ValueNotifier("00:00");
    _stopStopwatch();
    isClock = false;
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

/*
  late final OverlayEntry overlayEntry = OverlayEntry(builder: _overlayEntryBuilder);

  @override
  void dispose() {
    overlayEntry.dispose();
    super.dispose();
  }

  void insertOverlay() { // 적절한 타이밍에 호출
    if (!overlayEntry.mounted) {
      OverlayState overlayState = Overlay.of(context)!;
      overlayState.insert(overlayEntry);
    }
  }

  void removeOverlay() { // 적절한 타이밍에 호출
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  }

  Widget _overlayEntryBuilder(BuildContext context) {
    Offset position = _getOverlayEntryPosition();
    Size size = _getOverlayEntrySize();

    return Positioned(
      left: position.dx,
      top: position.dy,
      width: Get.size.width - MyConstants.SCREEN_HORIZONTAL_MARGIN.horizontal,
      child: AutoCompleteKeywordList(),
    );
  }

 */
  // 초기 카메라 위치
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(53.339688, -6.236688),
    zoom: 14.4746,
  );

  // 호수 위치
  static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: hamburger(),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (coordinate) {
              print("coordintate : $coordinate");
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Wrap(
              children: <Widget>[
                Container(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                        color: Colors.white,
                        child: Row(children: [
                          SizedBox(width: 7),
                          Text("출발지"),
                          SizedBox(width: 3),
                          Container(
                              margin: EdgeInsets.all(3),
                              width: 200,
                              child: TextFormField(
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                maxLength: 30,
                                decoration: const InputDecoration(
                                  counterText: '',
                                  counterStyle: TextStyle(fontSize: 14),
                                ),
                              )),
                          SizedBox(width: 90),
                          Ink(
                            decoration: const ShapeDecoration(
                              shape: CircleBorder(),
                              color: Colors.blue,
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search,
                                color: Color(0xff0E4A84),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      /*Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Builder(builder: (context) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.0)),
                            onPressed: () {
                              print("눌렸어");
                              Scaffold.of(context).openDrawer();
                            },
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          );
                        }),
                      ),*/
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  color: Colors.white,
                  child: Row(
                    children: [
                      SizedBox(width: 7),
                      Text("도착지"),
                      SizedBox(width: 3),
                      Container(
                          margin: EdgeInsets.all(3),
                          width: 200,
                          child: TextFormField(
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                            decoration: const InputDecoration(
                              counterText: '',
                              counterStyle: TextStyle(fontSize: 14),
                            ),
                          )),
                      SizedBox(width: 90),
                      Ink(
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search,
                              color: Color(0xff0E4A84)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SlidingUpPanel(
            parallaxEnabled: true,
            parallaxOffset: .5,
            controller: _pc,
            panel: Center(
              child: Container(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.directions_walk,
                              color: Colors.black,
                              size: 18.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '예상 소요 시간: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.directions_walk,
                              color: Colors.black,
                              size: 18.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              '평균 소요 시간: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        PathToggle(
                          title: '경로 상세',
                          content: Text(
                            '상세한 경로들\n경로들\n경로들..',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60.0),
                          child: Container(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff0E4A84),
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 23.0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 30.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0))),
                                onPressed: () {
                                  setState(() {
                                    isClock = true;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.timer,
                                      color: Colors.white,
                                      size: 23.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text('시간 측정'),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60.0),
                          child: Container(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff0E4A84),
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 23.0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 30.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0))),
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReportPage()))
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.drive_file_rename_outline,
                                      color: Colors.white,
                                      size: 23.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text('지름길 제보'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            header: _buildDragHandle(),
            body: _body(),
          ),
          if (isClock)
            Container(
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
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff0E4A84),
                            padding: EdgeInsets.all(25.0),
                            //textStyle: TextStyle(color: Colors.white, fontSize: 23.0),
                            shape: CircleBorder()),
                        onPressed: _resetStopwatch,
                        child: Text('Reset'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff0E4A84),
                            padding: EdgeInsets.all(25.0),
                            shape: CircleBorder(),
                          ),
                          onPressed: () {
                            setState(() {
                              isClock = false;
                            });
                          },
                          child: Text('Record'))
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
      /*
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _goToTheLake();
          _showBottomSheetScreen(); // Call the function to show BottomSheetScreen
        },
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),*/
    );
  }

  Widget _buildDragHandle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8),
      child: Container(
        width: 100,
        height: 5,
        margin: EdgeInsets.only(
          right: 500,
          left: 150,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      child: Column(children: <Widget>[]),
    );
  }

  Widget button({required String text, required Function() onPressed}) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(double.infinity, 50),
      ),
      child: Text(text),
    );
  }

  void _showBottomSheetScreen() {
    // Show the BottomSheetScreen using showModalBottomSheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BottomSheetScreen(),
    );
  }
}

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({Key? key}) : super(key: key);

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  Widget _buildDragHandle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8),
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }

  @override
  void initState() {
    animationController = BottomSheet.createAnimationController(this);
    animationController
      ..addListener(() {
        print(
            'listen : ${animationController.value}, : ${animationController.status}');
      })
      ..duration = const Duration(milliseconds: 500)
      ..reverseDuration = const Duration(milliseconds: 500);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  PanelController _pc = new PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        parallaxEnabled: true,
        parallaxOffset: .5,
        controller: _pc,
        panel: Center(
          child: Container(child: Text("This is the sliding Widget")),
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
    );
  }
}
