import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_to_hanyang/page/how_to_page.dart';
import 'package:road_to_hanyang/page/inquiry_board.dart';
import 'package:road_to_hanyang/page/setting_page.dart';
import 'package:road_to_hanyang/widget/panel_widget.dart';
import 'package:road_to_hanyang/widget/toggle.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../informations/locations.dart';
import '../screen/map_sample.dart';
import '../widget/hamburger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:road_to_hanyang/screen/map_result.dart';
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

class MapReportState extends State<MapReport> {
  bool isSuggestionVisible = false; // 추가된 부분
  List<LatLng> _polylinePoints = [];

  static final LatLngBounds _kHanyangBounds = LatLngBounds(
    southwest: LatLng(37.5565, 127.0458),
    northeast: LatLng(37.5569, 127.0469),
  );

  static const double _maxPadding = 150.0;
  static const double _paddingCoefficient = 10.0;
  final TextEditingController routesController = TextEditingController();


  void updateSuggestionVisibility() {
    isSuggestionVisible = startFocusNode.hasFocus || destFocusNode.hasFocus;
  }

  final TextEditingController startController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  late String startText;
  late String destText;
  Completer<GoogleMapController> _controller = Completer();
  FocusNode _focusNode = FocusNode();
  late FocusNode startFocusNode;
  late FocusNode destFocusNode;

  final panelController = PanelController();
  bool isPathPage = false;

  List<Marker> _markers = [];
  LatLng? selectedStartLocation;
  LatLng? selectedDestinationLocation;
  final Set<Polyline> _polyline = {};
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    startFocusNode = FocusNode();
    destFocusNode = FocusNode();
    fToast = FToast();
    fToast.init(context);

    // Add listener to focus nodes
    startFocusNode.addListener(() {
      updateSuggestionVisibility();
    });

    destFocusNode.addListener(() {
      updateSuggestionVisibility();
    });

    @override
    void dispose() {
      startFocusNode.dispose();
      destFocusNode.dispose();
      super.dispose();
    }
  }

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
          backgroundColor: Color(0xff0E4A84),
          iconTheme: IconThemeData(color: Colors.white),
          toolbarHeight: 100,
          //leadingWidth: 50,
          titleSpacing: 0,
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
                                          hideSuggestionsOnKeyboardHide: true,
                                          animationStart: 0,
                                          animationDuration: Duration.zero,
                                          textFieldConfiguration:
                                          TextFieldConfiguration(
                                              focusNode:
                                              startFocusNode, // _focusNode 추가
                                              controller: startController,
                                              autofocus: true,
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
                                            color: Colors.lightBlue[50],
                                          ),
                                          suggestionsCallback: (pattern) async {
                                            List<String> matches = <String>[];
                                            matches.addAll(suggestions);

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
                                          hideSuggestionsOnKeyboardHide: true,
                                          animationStart: 0,
                                          animationDuration: Duration.zero,
                                          textFieldConfiguration:
                                          TextFieldConfiguration(
                                              focusNode:
                                              destFocusNode, // _focusNode 추가
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
                                            matches.addAll(suggestions);

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
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    // Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => MapSample()));
                    // Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MapSample()),
                          (route) => false, // 모든 이전 화면 흔적을 제거
                    );
                  })
            ])
          ]),
      endDrawer: Hamburger(),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
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
              _handleTap(coordinate);
            },
            myLocationButtonEnabled: true, // 내 위치 버튼을 사용하지 않음
            minMaxZoomPreference: MinMaxZoomPreference(15, 18),
            padding: EdgeInsets.only(top: 60), // 상단에 여백 추가
            cameraTargetBounds: CameraTargetBounds(_kHanyangBounds),
          ),
          _drawPolylineButton(),
        ],
      ),
    );
  }
  // 클릭한 지점을 폴리라인에 추가하는 메서드
  void _handleTap(LatLng coordinate) {
    setState(() {
      _polylinePoints.add(coordinate);

      // Update polylines
      _updatePolylines();

      if(_markers.length == 0){
        _markers.add(
          Marker(
            markerId: MarkerId(coordinate.toString()),
            position: coordinate,
            infoWindow: InfoWindow(title: '출발지'),
          ),
        );
      }
      else {
        _markers.add(
          Marker(
            markerId: MarkerId(coordinate.toString()),
            position: coordinate,
            infoWindow: InfoWindow(title: '${_markers.length} 번째 경유지'),
          ),
        );
      }

    });
  }

  // 폴리라인 업데이트 및 추가하는 메서드
  void _updatePolylines() {
    _polyline.clear();
    _polyline.add(
      Polyline(
        polylineId: PolylineId('route'),
        points: _polylinePoints,
        color: Colors.blue,
        width: 3,
      ),
    );
  }

  // 폴리라인 지우는 메서드
  void _clearPolylines() {
    List<GeoPoint> geoPoints = [];

    // Generate a unique identifier for the subcollection
    String subcollectionId = "From : " + startText + " To : " + destText;

    for (LatLng point in _polylinePoints) {
      GeoPoint geoPoint = GeoPoint(point.latitude, point.longitude);
      geoPoints.add(geoPoint);
    }

    for(int i = 0; i < _markers.length; i++){
      addRoute(_markers[i].position.latitude, _markers[i].position.longitude, subcollectionId);
    }
    addGeoPointsToFirestore(geoPoints, subcollectionId);

    setState(() {
      toastMessage();
      //controller: routesController,
      _polylinePoints.clear();
      _polyline.clear();
      _markers.clear();
    });
  }

  void addGeoPointsToFirestore(List<GeoPoint> geoPoints, String subcollectionId) {
    // Reference to the subcollection under 'routes'
    CollectionReference geoPointsCollection = FirebaseFirestore.instance
        .collection('routes')
        .doc(subcollectionId) // Use the generated subcollectionId
        .collection('coordinates');

    // Iterate through the list of GeoPoints and add them to Firestore
    for (GeoPoint geoPoint in geoPoints) {
      geoPointsCollection.add({
        'location': geoPoint,
      });
    }
  }

  // 폴리라인을 그리는 버튼 위젯
  Widget _drawPolylineButton() {
    return Positioned(
      bottom: 16,
      right: MediaQuery.of(context).size.width * 0.40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Color(0xff0E4A84)),
        onPressed: _clearPolylines,
        child: Text('등록' ,style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600),),
      ),
    );
  }

  Widget button({required String text, required Function() onPressed}) {
    return TextButton(
    style: TextButton.styleFrom(
    backgroundColor: const Color(0xff0E4A84)),
    onPressed: () {
    //toastMessage();
    },
    child: const Text('등록',
    style: TextStyle(color: Colors.white, fontSize: 14))
    );
  }

  toastMessage() {
    Widget toast = Container(
        margin: const EdgeInsets.only(bottom: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xff0E4A84).withOpacity(0.5),
        ),
        child: const Text(
          "등록되었습니다. 감사합니다:)",
          style: TextStyle(color: Colors.white),
        ));

    fToast.showToast(child: toast, toastDuration: const Duration(seconds: 2));
  }

  void addRoute(double latitude, double longitude, String subcollectionId) {
    if (routesController.text.isNotEmpty) {
      // Reference to the subcollection under 'routes'
      CollectionReference routeCollection = FirebaseFirestore.instance
          .collection('routes')
          .doc(subcollectionId) // Use the generated subcollectionId
          .collection('routes');

      // Convert the current location to GeoPoint
      GeoPoint currentLocation = GeoPoint(latitude, longitude);

      // Add GeoPoint to the subcollection
      routeCollection.add({
        'location': currentLocation,
      });

      routesController.clear();
    }
  }

}

class MapReport extends StatefulWidget {
  @override
  State<MapReport> createState() => MapReportState();
}

class CustomFabLoc extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
      scaffoldGeometry.scaffoldSize.width -
          scaffoldGeometry.floatingActionButtonSize.width,
      scaffoldGeometry.scaffoldSize.height -
          scaffoldGeometry.floatingActionButtonSize.height * 2 - 40,
    );
  }
}