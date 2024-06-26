import 'dart:async';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_to_hanyang/page/how_to_page.dart';
import 'package:road_to_hanyang/page/inquiry_board.dart';
import 'package:road_to_hanyang/page/map_report.dart';
import 'package:road_to_hanyang/page/setting_page.dart';
import 'package:road_to_hanyang/widget/panel_widget.dart';
import 'package:road_to_hanyang/widget/toggle.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../informations/locations.dart';
import '../widget/bottom_widget.dart';
import '../widget/hamburger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:road_to_hanyang/screen/map_result.dart';
import 'dart:math';

// import 'package:location/location.dart' hide LocationAccuracy;

// var ITBT = LatLng(37.555965, 127.049380);
// var BUB = LatLng(37.556254, 127.048330); // 법학포탈
// var EF = LatLng(37.556599, 127.048039); // 경제금융관
// var HP = LatLng(37.557265, 127.048480); // 행파
// var IG = LatLng(37.556679, 127.045816); // 1공
// var EV = LatLng(37.555838, 127.047244); // 대운동장 엘베
// var DU = LatLng(37.555312, 127.048595); // 대운동장 주차장
// var EVE = LatLng(37.556240, 127.046767); // 엘베 끝
// var P1 = LatLng(37.556450, 127.046675);
// var P2 = LatLng(37.556339, 127.046306);
// var P3 = LatLng(37.556625, 127.046125);
//
// List<LatLng> route1 = [ITBT, BUB, EF, HP]; // ITBT to HP
// List<LatLng> route2 = [ITBT, DU, EV, P1, P2, P3];
// List<LatLng> route3 = [ITBT, DU, EV, P1, P2, P3];
// List<LatLng> route4 = [ITBT, DU, EV, P1, P2, P3];
//
// List<List<LatLng>> routes = [route1, route2, route3];
//
// LatLng getlocation(String text) {
//   switch (text) {
//     case "itbt관":
//       return ITBT;
//     case "제 1공학관":
//       return IG;
//     case "제 2공학관":
//       return EV;
//     case "itbt관":
//       return ITBT;
//     case "행원파크":
//       return HP;
//     case "공업센터":
//       return EF;
//     case "사자가 군것질 할 때":
//       return BUB;
//     case "대운동장":
//       return DU;
//     case "백남음악관":
//       return EVE;
//     case "노천극장":
//       return P1;
//     // 추가적인 임의의 장소에 대한 정보를 추가할 수 있습니다.
//     default:
//       // 디폴트로 ITBT 위치를 반환합니다.
//       return ITBT;
//   }
// }

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  bool isSuggestionVisible = false; // 추가된 부분

  static final LatLngBounds _kHanyangBounds = LatLngBounds(
    southwest: LatLng(37.5565, 127.0458),
    northeast: LatLng(37.5569, 127.0469),
  );

  static const double _maxPadding = 150.0;
  static const double _paddingCoefficient = 10.0;

  void updateSuggestionVisibility() {
    isSuggestionVisible = startFocusNode.hasFocus || destFocusNode.hasFocus;
  }


  final TextEditingController startController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  String startText = "NONE";
  String? destText = "NONE";
  Completer<GoogleMapController> _controller = Completer();
  FocusNode _focusNode = FocusNode();
  late FocusNode startFocusNode;
  late FocusNode destFocusNode;

  // final panelController = PanelController();
  // bool isPathPage = false;

  List<Marker> _markers = [];
  LatLng? selectedStartLocation;
  LatLng? selectedDestinationLocation;
  final Set<Polyline> _polyline = {};

  int _selectedIndex = -1;

  final List<Widget> _widgetOptions = <Widget>[
    BottomWidget(index: 0),
    BottomWidget(index: 1),
    BottomWidget(index: 2),
    BottomWidget(index: 3),
    Setting()
  ];

  void _onItemTapped(int index) {
    if (index == 4) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => _widgetOptions[index]));
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startFocusNode = FocusNode();
    destFocusNode = FocusNode();

    // Add listener to focus nodes
    startFocusNode.addListener(() {
      updateSuggestionVisibility();
    });

    destFocusNode.addListener(() {
      updateSuggestionVisibility();
    });

    /* void updateSuggestionVisibility() {
      setState(() {
        isSuggestionVisible = startFocusNode.hasFocus || destFocusNode.hasFocus;
      });
    }*/

    @override
    void dispose() {
      startFocusNode.dispose();
      destFocusNode.dispose();
      super.dispose();
    }

    /*_markers.add(Marker(
        markerId: MarkerId("0"),
        draggable: true,
        onTap: () => print(_markers.first.position),
        position: route1[0]));
    _markers.add(Marker(
        markerId: MarkerId("1"),
        draggable: true,
        onTap: () => print("Marker!"),
        position: route1[3]));
    _polyline.add(Polyline(
        polylineId: PolylineId('1'), points: route1, color: Colors.green));*/
  }

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
    target: LatLng(37.556040, 127.044746),
    zoom: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color(0xff0E4A84)),
          toolbarHeight: 94,
          titleSpacing: 11,
          //leadingWidth: 50,
          title: Container(
              height: 94,
              child: SingleChildScrollView(
                  //padding: EdgeInsets.only(top: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    //  mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                    height: 36,
                    //width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                child: TypeAheadField(
                                  hideSuggestionsOnKeyboardHide: true,
                                  animationStart: 0,
                                  animationDuration: Duration.zero,
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          keyboardType: TextInputType.visiblePassword,
                                          focusNode:
                                              startFocusNode, // _focusNode 추가
                                          controller: startController,
                                          //autofocus: true,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            hintText: "출발지를 입력하세요",
                                            hintStyle: TextStyle(
                                                color: Color(0xff6B6B6B),
                                                fontWeight: FontWeight.w100),
                                          )),
                                  suggestionsBoxDecoration:
                                      SuggestionsBoxDecoration(
                                    color: Colors.lightBlue[50],
                                  ),
                                  suggestionsCallback: (pattern) async {
                                    List<String> matches = <String>[];
                                    matches.addAll(suggestions);

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
                                    setState(() {
                                      this.startController.text = suggestion;
                                      startText = suggestion;
                                      _markers.removeAt(0);
                                      _markers.add(Marker(
                                        markerId: MarkerId("0"),
                                        draggable: true,
                                        onTap: () => print("Marker!"),
                                        position:
                                            getlocation(startController.text),
                                      ));
                                    });
                                  })))
                    ])),
                SizedBox(height: 4),
                Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                    height: 36,
                    //width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                    child: Row(children: [
                      Expanded(
                          child: Container(
                              child: TypeAheadField(
                                  hideSuggestionsOnKeyboardHide: true,
                                  animationStart: 0,
                                  animationDuration: Duration.zero,
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                        enableSuggestions: false,
                                          focusNode:
                                              destFocusNode, // _focusNode 추가
                                          controller: destinationController,
                                          //
                                          // autofocus: true,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              hintText: "도착지를 입력하세요",
                                              hintStyle: TextStyle(
                                                color: Color(0xff6B6B6B),
                                                fontWeight: FontWeight.w100,
                                              ))),
                                  suggestionsBoxDecoration:
                                      SuggestionsBoxDecoration(
                                          color: Colors.lightBlue[50]),
                                  suggestionsCallback: (pattern) async {
                                    List<String> matches = <String>[];
                                    matches.addAll(suggestions);

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
                                    this.destinationController.text =
                                        suggestion;
                                    destText = suggestion;
                                  })))
                    ]))
              ]))),
          actions: [
            Column(children: [
              Builder(builder: (context) {
                return Transform.rotate(
                  angle: 90 * pi / 180,
                    child: SizedBox(
                        height: 40,
                        width: 40,
                        child: IconButton(
                    icon: Icon(Icons.compare_arrows),
                   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    iconSize: 30,
                    onPressed: () {
                      String str;
                      if(startController.text != null && destinationController.text != null) {
                        str = startController.text;
                        startController.text = destinationController.text;
                        destinationController.text = str;
                        startText = startController.text;
                        destText = destinationController.text;
                      }
                      //  Scaffold.of(context).openEndDrawer();
                    }
                    ))
                );
              }),
              SizedBox(
                 height: 40,
                  width: 40,
                  child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (startController.text != startText)
                      Fluttertoast.showToast(
                        msg: "출발지를 입력해주세요!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    else if (destinationController.text != destText)
                      Fluttertoast.showToast(
                        msg: "도착지를 입력해주세요!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    else if(destinationController.text == startController.text){
                      Fluttertoast.showToast(
                        msg: "출발지와 도착지가 동일합니다!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                    else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MapResult(
                                      startText: startController.text,
                                      destText: destinationController.text)));
                    }
                  }
                  ))
            ])
          ]),
      floatingActionButtonLocation: CustomFabLoc(),
      floatingActionButton: FloatingActionButton(

        onPressed: () async {
          GoogleMapController _gc = await _controller.future;
          LocationPermission permission = await Geolocator.requestPermission();
          var gps = await getCurrentLocation();
          _gc.animateCamera(
              CameraUpdate.newLatLng(LatLng(gps.latitude, gps.longitude)));

          /* setState(() {
            //  내 위치 가져오는 코드
            _markers.add(Marker(
                markerId: MarkerId("2"),
                draggable: true,
                onTap: () => print("Marker!"),
                position: LatLng(gps.latitude, gps.longitude)));
          });
*/
        },

        child: Icon(Icons.my_location_rounded),
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
      ),

      // endDrawer: Hamburger(),
      body: Stack(
        children: [
          // TODO: 그림자 왜 표현안댐?
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                //width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent
                    ])),
              )),
          GoogleMap(
            polylines: _polyline,
            mapType: MapType.normal,
            markers: Set.from(_markers),
            zoomGesturesEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (coordinate) {
              print("coordintate : $coordinate");
            },
            myLocationButtonEnabled: true, // 내 위치 버튼을 사용하지 않음
            minMaxZoomPreference: MinMaxZoomPreference(15, 18),
            padding: EdgeInsets.only(top: 60), // 상단에 여백 추가
            cameraTargetBounds: CameraTargetBounds(_kHanyangBounds),
          ),
          // Positioned(
          //   bottom: 12,
          //   child: Container(
          //       padding: EdgeInsets.symmetric(horizontal: 24),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           GestureDetector(
          //               child: Container(
          //                   width: MediaQuery.of(context).size.width * 0.5 - 36,
          //                   height: 43,
          //                   decoration: BoxDecoration(
          //                       color: Color(0xff0E4A84),
          //                       borderRadius: BorderRadius.circular(30)),
          //                   child: Center(
          //                       child: Text(
          //                     '지름길 제보',
          //                     style: TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 22,
          //                         fontWeight: FontWeight.w600),
          //                   ))),
          //               onTap: () {
          //                 Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) => MapReport()));
          //               }),
          //           SizedBox(width: 24),
          //           GestureDetector(
          //               child: Container(
          //                   width: MediaQuery.of(context).size.width * 0.5 - 36,
          //                   height: 43,
          //                   decoration: BoxDecoration(
          //                       color: Color(0xff0E4A84),
          //                       borderRadius: BorderRadius.circular(30)),
          //                   child: Center(
          //                       child: Text('문의',
          //                           style: TextStyle(
          //                               color: Colors.white,
          //                               fontSize: 22,
          //                               fontWeight: FontWeight.w600)))),
          //               onTap: () {
          //                 Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) => const InquiryBoard()));
          //               }),
          //         ],
          //       )),
          // ),
          _widgetOptions.elementAt(_selectedIndex),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        iconSize: 22,
        unselectedItemColor: Color(0xff0E4A84),
        selectedItemColor: Color(0xff0E4A84),
        // unselectedIconTheme: const IconThemeData(size: 25),
        // selectedIconTheme: const IconThemeData(size: 30),
        // unselectedFontSize: 11,
        // selectedFontSize: 13,
        unselectedLabelStyle:
            TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
        selectedLabelStyle:
            TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        //fixedColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              label: '편의시설',
              icon: Icon(Icons.lightbulb_outline),
              activeIcon: Icon(Icons.lightbulb)),
          BottomNavigationBarItem(
              label: '문의',
              icon: Icon(Icons.chat_bubble_outline_rounded),
              activeIcon: Icon(Icons.chat_bubble_rounded)),
          BottomNavigationBarItem(
              label: '즐겨찾기',
              icon: Icon(Icons.bookmark_outline_rounded),
              activeIcon: Icon(Icons.bookmark_rounded)),
          BottomNavigationBarItem(
              label: 'About',
              icon: Icon(Icons.folder_outlined),
              activeIcon: Icon(Icons.folder_rounded)),
          BottomNavigationBarItem(
              label: '설정',
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings_rounded))
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
}

class CustomFabLoc extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
      scaffoldGeometry.scaffoldSize.width -
          scaffoldGeometry.floatingActionButtonSize.width,
      scaffoldGeometry.scaffoldSize.height -
          scaffoldGeometry.floatingActionButtonSize.height * 2 -
          40,
    );
  }
}