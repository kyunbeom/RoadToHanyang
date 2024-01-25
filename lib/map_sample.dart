import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_to_hanyang/page/how_to_page.dart';
import 'package:road_to_hanyang/page/inquiry_board.dart';
import 'package:road_to_hanyang/page/setting_page.dart';
import 'package:road_to_hanyang/widget/panel_widget.dart';
import 'package:road_to_hanyang/toggle.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'informations/locations.dart';
import 'widget/hamburger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:road_to_hanyang/map_result.dart';
//import 'package:location/location.dart' hide LocationAccuracy;

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
  final TextEditingController startController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  late String startText;
  late String destText;
  Completer<GoogleMapController> _controller = Completer();

  final panelController = PanelController();
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
    "노천극장",
    "애지문",
    "사회과학대학",
    "인문대학",
    "에러발생"
  ];

  List<Marker> _markers = [];
  LatLng? selectedStartLocation;
  LatLng? selectedDestinationLocation;
  final Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();
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
    target: LatLng(37.556022, 127.044741),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff0E4A84),
          iconTheme: IconThemeData(color: Colors.white),
          toolbarHeight: 100,
          //leadingWidth: 50,
          title: Container(
              height: 150,
              child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            height: 40,
                            //width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5))),
                            child: Row(children: [
                              Expanded(
                                  child: Container(
                                      child: TypeAheadField(
                                          animationStart: 0,
                                          animationDuration: Duration.zero,
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                                  controller: startController,
                                                  autofocus: false,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                  decoration: InputDecoration(
                                                    hintText: "출발지를 입력해주세요",
                                                    hintStyle: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                          suggestionsBoxDecoration:
                                              SuggestionsBoxDecoration(
                                                  color: Colors.lightBlue[50]),
                                          suggestionsCallback: (pattern) async {
                                            List<String> matches = <String>[];
                                            matches.addAll(suggestons);

                                            matches.retainWhere((s) {
                                              return s.toLowerCase().contains(
                                                  pattern.toLowerCase());
                                            });

                                            return matches;
                                          },
                                          itemBuilder: (context, suggestion) {
                                            return Card(
                                                child: Container(
                                              padding: EdgeInsets.all(8),
                                              child:
                                                  Text(suggestion.toString()),
                                            ));
                                          },
                                          onSuggestionSelected: (suggestion) {
                                            setState(() {
                                              this.startController.text =
                                                  suggestion;
                                              startText = suggestion;
                                              _markers.removeAt(0);
                                              _markers.add(Marker(
                                                markerId: MarkerId("0"),
                                                draggable: true,
                                                onTap: () => print("Marker!"),
                                                position: getlocation(
                                                    startController.text),
                                              ));
                                            });
                                          })))
                            ])),
                        SizedBox(height: 3),
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            height: 40,
                            //width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                            child: Row(children: [
                              Expanded(
                                  child: Container(
                                      child: TypeAheadField(
                                          animationStart: 0,
                                          animationDuration: Duration.zero,
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                                  controller:
                                                      destinationController,
                                                  autofocus: true,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                  decoration: InputDecoration(
                                                      hintText: "도착지를 입력해주세요",
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Colors.white))),
                                          suggestionsBoxDecoration:
                                              SuggestionsBoxDecoration(
                                                  color: Colors.lightBlue[50]),
                                          suggestionsCallback: (pattern) async {
                                            List<String> matches = <String>[];
                                            matches.addAll(suggestons);

                                            matches.retainWhere((s) {
                                              return s.toLowerCase().contains(
                                                  pattern.toLowerCase());
                                            });
                                            print(
                                                'Suggestions for $pattern: $matches');
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
                return IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    });
              }),
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if(startText == null)
                      this.startController.text = "출발지를 다시 입력해주세요";
                    if(destText == null)
                      this.destinationController.text = "도착지를 다시 입력해주세요";
                    if(startText != null && destText != null)
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MapResult(startText: startText , destText : destText)));

                  })
            ])
          ]),
      endDrawer: Hamburger(),
      body: Stack(
        children: [
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
          ),

          // TODO: 이게 맵 위에 있도록 해야함
          SlidingUpPanel(
            controller: panelController,
            parallaxEnabled: true,
            // TODO: 바텀시트 올라갈때 지도도 같이?
            parallaxOffset: .5,
            maxHeight: MediaQuery.of(context).size.height * 0.6,
            // TODO: 어디까지 보이게 ㅔ할건지
            minHeight: 200,
            //TODO: 적당한 사이즈로 맞추기
            panelBuilder: (controller) => PanelWidget(
              minute: 10,
              controller: controller,
              panelController: panelController,
              isPathPage: true, // TODO: 경로페이지인지 홈인지 결정어디선가 바꿔줘야함
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
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
          //                     '사용 방법',
          //                     style: TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 22,
          //                         fontWeight: FontWeight.w600),
          //                   ))),
          //               onTap: () {
          //                 Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                         builder: (context) => const HowToPage()));
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
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          GoogleMapController _gc = await _controller.future;
          LocationPermission permission = await Geolocator.requestPermission();
          var gps = await getCurrentLocation();
          _gc.animateCamera(
              CameraUpdate.newLatLng(LatLng(gps.latitude, gps.longitude)));

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
            /*_polyline.add(Polyline(
              polylineId: PolylineId('1'),
              points: route2,
              color: Colors.green,
            ));*/

            //  내 위치 가져오는 코드
            _markers.add(Marker(
                markerId: MarkerId("2"),
                draggable: true,
                onTap: () => print("Marker!"),
                position: LatLng(gps.latitude, gps.longitude)));
          });

          // _goToTheLake();
          // _showBottomSheetScreen(); // Call the function to show BottomSheetScreen
        },
        label: Text('내 위치로'),
        icon: Icon(Icons.location_city),
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
