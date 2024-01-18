import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_to_hanyang/info.dart';
import 'package:road_to_hanyang/widget/panel_widget.dart';
import 'package:road_to_hanyang/report.dart';
import 'package:road_to_hanyang/toggle.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'widget/hamburger.dart';
import 'package:geolocator/geolocator.dart';

var ITBT = LatLng(37.555965, 127.049380);
var BUB = LatLng(37.556254, 127.048330); // 법학포탈
var EF = LatLng(37.556599, 127.048039); // 경제금융관
var HP = LatLng(37.557265, 127.048480); // 행파
var IG = LatLng(37.556679, 127.045816); // 1공
var EV = LatLng(37.555838, 127.047244); // 대운동장 엘베
var DU = LatLng(37.555312, 127.048595); // 대운동장 주차장
var EVE = LatLng(37.556240, 127.046767); // 엘베 끝
var P1 = LatLng(37.556450, 127.046675);
var P2 = LatLng(37.556339, 127.046306);
var P3 = LatLng(37.556625, 127.046125);

List<LatLng> route1 = [ITBT, BUB, EF, HP];
List<LatLng> route2 = [ITBT, DU, EV, P1, P2, P3];

Set<Polyline> polylinePoints = {};

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final TextEditingController startController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();

  final pannelController = PanelController();
  bool isPathPage = false;

  List<String> suggestons = [
    "제 1공학관",
    "제 2공학관",
    "itbt관",
    "행원파크",
    "공업센터",
    "사자가 군것질 할 때",
    "대운동장",
    "백남음악관",
    "노천극장"
  ];
  List<Marker> _markers = [];
  LatLng? selectedStartLocation;
  LatLng? selectedDestinationLocation;
  final Set<Polyline> _polyline = {};

  // final Stopwatch _stopwatch = Stopwatch();
  // late final Duration _refreshRate;
  // late final ValueNotifier<String> _timeDisplay;
  // bool isRun = false;
  // bool isClock = false;

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
        markerId: MarkerId("0"),
        draggable: true,
        onTap: () => print("Marker!"),
        position: route1[0]));
    _markers.add(Marker(
        markerId: MarkerId("1"),
        draggable: true,
        onTap: () => print("Marker!"),
        position: route1[3]));
    // _polyline.add(Polyline(
    //     polylineId: PolylineId('1'), points: route1, color: Colors.green));
    // _refreshRate = Duration(milliseconds: 100); // 업데이트 주기
    // _timeDisplay = ValueNotifier("00:00");
    // _stopStopwatch();
    // isClock = false;
  }

  //
  // void _startStopwatch() {
  //   _stopwatch.start();
  //   setState(() {
  //     isRun = true;
  //   });
  //   _updateTime();
  // }
  //
  // void _updateTime() {
  //   if (isRun) {
  //     Future.delayed(_refreshRate, _updateTime);
  //   }
  //   int milliseconds = _stopwatch.elapsedMilliseconds;
  //   int seconds = (milliseconds / 1000).floor();
  //   int minutes = (seconds / 60).floor();
  //   seconds %= 60;
  //   minutes %= 60;
  //   String formattedTime =
  //       "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  //   _timeDisplay.value = formattedTime;
  // }
  //
  // void _stopStopwatch() {
  //   _stopwatch.stop();
  //   setState(() {
  //     isRun = false;
  //   });
  // }
  //
  // void _resetStopwatch() {
  //   _stopwatch.reset();
  //   _timeDisplay.value = "00:00";
  // }
  //
  // @override
  // void dispose() {
  //   _stopwatch.stop();
  //   super.dispose();
  // }

  // late final OverlayEntry overlayEntry = OverlayEntry(builder: _overlayEntryBuilder);
  //
  // @override
  // void dispose() {
  //   overlayEntry.dispose();
  //   super.dispose();
  // }

  // void insertOverlay() { // 적절한 타이밍에 호출
  //   if (!overlayEntry.mounted) {
  //     OverlayState overlayState = Overlay.of(context)!;
  //     overlayState.insert(overlayEntry);
  //   }
  // }
  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  // 초기 카메라 위치
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.556022, 127.044741),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0E4A84),
        toolbarHeight: 100,
        leadingWidth: 50,
        title: Container(
          height: 150,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  // color: Colors.white.withOpacity(0.5),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 40,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: TypeAheadField(
                            animationStart: 0,
                            animationDuration: Duration.zero,
                            textFieldConfiguration: TextFieldConfiguration(
                                controller: startController,
                                autofocus: false,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: "출발지를 입력해주세요",
                                  hintStyle: TextStyle(color: Colors.white),
                                  // border: OutlineInputBorder()
                                )),
                            // TODO: 이거 좀 밑으로 못내림?
                            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                color: Colors.lightBlue[50]),
                            suggestionsCallback: (pattern) async {
                              List<String> matches = <String>[];
                              matches.addAll(suggestons);

                              matches.retainWhere((s) {
                                return s
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase());
                              });

                              return matches;
                            },
                            itemBuilder: (context, suggestion) {
                              return Card(
                                  child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(suggestion.toString()),
                              ));
                            },
                            onSuggestionSelected: (suggestion) {
                              this.startController.text = suggestion;
                              print('Selected suggestion: $suggestion');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  // margin: EdgeInsets.all(3),
                  // color: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 40,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Row(
                    children: [
                      //SizedBox(width: 7),
                      Expanded(
                        child: Container(
                            //margin: EdgeInsets.all(3),
                            //width: 200,
                            child: TypeAheadField(
                          // controller: destinationController,
                          animationStart: 0,
                          animationDuration: Duration.zero,
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: destinationController,
                              autofocus: true,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  hintText: "도착지를 입력해주세요",
                                  hintStyle: TextStyle(color: Colors.white)
                                  // border: OutlineInputBorder()
                                  )),
                          suggestionsBoxDecoration: SuggestionsBoxDecoration(
                              color: Colors.lightBlue[50]),
                          suggestionsCallback: (pattern) async {
                            List<String> matches = <String>[];
                            matches.addAll(suggestons);

                            matches.retainWhere((s) {
                              return s
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase());
                            });
                            print('Suggestions for $pattern: $matches');
                            return matches;
                          },
                          itemBuilder: (context, sone) {
                            return Card(
                                child: Container(
                              padding: EdgeInsets.all(8),
                              child: Text(sone.toString()),
                            ));
                          },
                          onSuggestionSelected: (suggestion) {
                            this.destinationController.text = suggestion;
                            print('Selected suggestion: $suggestion');
                          },
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // actions: [
        //   Column(
        //     children: [
        //       IconButton(
        //           icon: Icon(Icons.menu),
        //           onPressed: () {
        //             _scaffoldKey.currentState!.openEndDrawer();
        //           }),
        //       SizedBox(
        //         height: 40,
        //       )
        //     ],
        //   ),
        // ],
      ),
      endDrawer: Hamburger(),
      body: Stack(
        children: [
          GoogleMap(
            polylines: _polyline,
            mapType: MapType.normal,
            markers: Set.from(_markers),
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (coordinate) {
              print("coordintate : $coordinate");
            },
          ),

          // TODO: 이게 맵 위에 있도록 해야함
          SlidingUpPanel(
            controller: pannelController,
            parallaxEnabled: true,
            // TODO: 바텀시트 올라갈때 지도도 같이?
            parallaxOffset: .5,
            // controller: controller,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            // TODO: 어디까지 보이게 ㅔ할건지
            minHeight: MediaQuery.of(context).size.height * 0.1,
            //TODO: 적당한 사이즈로 맞추기
            panelBuilder: (controller) => PanelWidget(
              minute: 10,
              controller: controller,
              panelController: pannelController,
              isPathPage: false, // TODO: 경로페이지인지 홈인지 결정어디선가 바꿔줘야함
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            // panel: Center(
            //   child: Container(
            //     child: Center(
            //       child: Container(
            //         padding: EdgeInsets.symmetric(horizontal: 20.0),
            //         child: Column(
            //           children: [
            //             SizedBox(
            //               height: 30,
            //             ),
            //             Row(
            //               children: [
            //                 Icon(
            //                   Icons.directions_walk,
            //                   color: Colors.black,
            //                   size: 18.0,
            //                 ),
            //                 SizedBox(
            //                   width: 10.0,
            //                 ),
            //                 Text(
            //                   '예상 소요 시간: ',
            //                   style: TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 18.0,
            //                   ),
            //                 )
            //               ],
            //             ),
            //             SizedBox(
            //               height: 10,
            //             ),
            //             Row(
            //               children: [
            //                 Icon(
            //                   Icons.directions_walk,
            //                   color: Colors.black,
            //                   size: 18.0,
            //                 ),
            //                 SizedBox(
            //                   width: 10.0,
            //                 ),
            //                 Text(
            //                   '평균 소요 시간: ',
            //                   style: TextStyle(
            //                     color: Colors.black,
            //                     fontSize: 18.0,
            //                   ),
            //                 )
            //               ],
            //             ),
            //             SizedBox(
            //               height: 30.0,
            //             ),
            //             PathToggle(
            //               title: '경로 상세',
            //               content: Text(
            //                 '상세한 경로들\n경로들\n경로들..',
            //                 style: TextStyle(
            //                   color: Colors.black,
            //                   fontSize: 15.0,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               height: 30.0,
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 60.0),
            //               child: Container(
            //                   alignment: Alignment.center,
            //                   child: ElevatedButton(
            //                     style: ElevatedButton.styleFrom(
            //                         backgroundColor: Color(0xff0E4A84),
            //                         textStyle: TextStyle(
            //                             color: Colors.white, fontSize: 23.0),
            //                         padding: const EdgeInsets.symmetric(
            //                             vertical: 10.0, horizontal: 30.0),
            //                         shape: RoundedRectangleBorder(
            //                             borderRadius:
            //                                 BorderRadius.circular(50.0))),
            //                     onPressed: () {
            //                       setState(() {
            //                         isClock = true;
            //                       });
            //                     },
            //                     child: Row(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: const [
            //                         Icon(
            //                           Icons.timer,
            //                           color: Colors.white,
            //                           size: 23.0,
            //                         ),
            //                         SizedBox(
            //                           width: 10.0,
            //                         ),
            //                         Text('시간 측정',
            //                             style: TextStyle(color: Colors.white)),
            //                       ],
            //                     ),
            //                   )),
            //             ),
            //             SizedBox(
            //               height: 10.0,
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 60.0),
            //               child: Container(
            //                   alignment: Alignment.center,
            //                   child: ElevatedButton(
            //                     style: ElevatedButton.styleFrom(
            //                         backgroundColor: Color(0xff0E4A84),
            //                         textStyle: TextStyle(
            //                             color: Colors.white, fontSize: 23.0),
            //                         padding: const EdgeInsets.symmetric(
            //                             vertical: 10.0, horizontal: 30.0),
            //                         shape: RoundedRectangleBorder(
            //                             borderRadius:
            //                                 BorderRadius.circular(50.0))),
            //                     onPressed: () => {
            //                       Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                               builder: (context) => ReportPage()))
            //                     },
            //                     child: Row(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: const [
            //                         Icon(
            //                           Icons.drive_file_rename_outline,
            //                           color: Colors.white,
            //                           size: 23.0,
            //                         ),
            //                         SizedBox(
            //                           width: 10.0,
            //                         ),
            //                         Text('지름길 제보',
            //                             style: TextStyle(color: Colors.white)),
            //                       ],
            //                     ),
            //                   )),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            // header: _buildDragHandle(),
            // body: _body(),
          ),
          // ... Previous code

          // ... Previous code

          // if (isClock)
          //   Container(
          //     padding: EdgeInsets.only(
          //         top: 190,
          //         left: 150), // Adjust the top and left padding values
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         ValueListenableBuilder(
          //           valueListenable: _timeDisplay,
          //           builder: (context, value, child) {
          //             return Text(
          //               value,
          //               style: TextStyle(fontSize: 30),
          //             );
          //           },
          //         ),
          //         SizedBox(height: 18),
          //         Row(
          //           mainAxisAlignment:
          //               MainAxisAlignment.center, // Adjust the alignment
          //           children: [
          //             ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                 backgroundColor: Color(0xff0E4A84),
          //                 padding: EdgeInsets.all(20.0),
          //                 shape: CircleBorder(),
          //               ),
          //               onPressed: isRun ? _stopStopwatch : _startStopwatch,
          //               child: Text(isRun ? 'Stop' : 'Start',
          //                   style: TextStyle(color: Colors.white)),
          //             ),
          //             SizedBox(width: 10),
          //             ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                 backgroundColor: Color(0xff0E4A84),
          //                 padding: EdgeInsets.all(20.0),
          //                 shape: CircleBorder(),
          //               ),
          //               onPressed: _resetStopwatch,
          //               child: Text('Reset',
          //                   style: TextStyle(color: Colors.white)),
          //             ),
          //             SizedBox(width: 10),
          //             ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                 backgroundColor: Color(0xff0E4A84),
          //                 padding: EdgeInsets.all(20.0),
          //                 shape: CircleBorder(),
          //               ),
          //               onPressed: () {
          //                 setState(() {
          //                   isClock = false;
          //                 });
          //               },
          //               child: Text('Record'),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),

// ... Rest of the code

// ... Rest of the code
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // final GoogleMapController _gc = await _controller.future;
          // LocationPermission permission = await Geolocator.requestPermission();
          // var gps = await getCurrentLocation();
          // _gc.animateCamera(
          //     CameraUpdate.newLatLng(LatLng(gps.latitude, gps.longitude)));
          setState(() {
            _markers.removeAt(0);
            _markers.removeAt(0);

            _markers.add(Marker(
                markerId: MarkerId("0"),
                draggable: true,
                onTap: () => print("Marker!"),
                position: route2[0]));
            _markers.add(Marker(
                markerId: MarkerId("1"),
                draggable: true,
                onTap: () => print("Marker!"),
                position: route2[5]));
            _polyline.add(Polyline(
              polylineId: PolylineId('1'),
              points: route2,
              color: Colors.green,
            ));

            //  내 위치 가져오는 코드
            // _markers.add(Marker(
            //     markerId: MarkerId("1"),
            //     draggable: true,
            //     onTap: () => print("Marker!"),
            //     position: LatLng(gps.latitude, gps.longitude)));
          });

          // _goToTheLake();
          // _showBottomSheetScreen(); // Call the function to show BottomSheetScreen
        },
        label: Text('내 위치로'),
        icon: Icon(Icons.location_city),
      ),
    );
  }

  // Widget _buildDragHandle() {
  //   return Container(
  //     alignment: Alignment.center,
  //     padding: EdgeInsets.only(top: 8),
  //     child: Container(
  //       width: 40,
  //       height: 5,
  //       margin: EdgeInsets.only(
  //         right: 500,
  //         left: 150,
  //       ),
  //       decoration: BoxDecoration(
  //         color: Colors.grey[300],
  //         borderRadius: BorderRadius.circular(5),
  //       ),
  //     ),
  //   );
  // }

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
        margin: EdgeInsets.only(
          left: (MediaQuery.of(context).size.width - 40) / 2, // 중앙으로 이동
          right: (MediaQuery.of(context).size.width - 40) / 2,
        ),
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
