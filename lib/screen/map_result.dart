import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_to_hanyang/widget/hamburger.dart';
import 'package:road_to_hanyang/widget/panel_widget.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../informations/locations.dart';
import 'package:geolocator/geolocator.dart';
import 'map_sample.dart';

bool vibration = false;

class MapResult extends StatefulWidget {
  final String startText;
  final String destText;

  const MapResult({Key? key, required this.startText, required this.destText})
      : super(key: key);

  @override
  State<MapResult> createState() => _MapResultState();
}

class _MapResultState extends State<MapResult> {
  final TextEditingController startController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();

  final panelController = PanelController();

  // List<String> suggestons = [
  //   "제 1공학관",
  //   "제 2공학관",
  //   "itbt관",
  //   "행원파크",
  //   "공업센터",
  //   "사자가 군것질 할 때",
  //   "대운동장",
  //   "백남음악관",
  //   "노천극장",
  //   "애지문",
  //   "사회과학대학",
  //   "인문대학",
  //   "에러발생"
  // ];

  List<Marker> _markers = [];
  LatLng? selectedStartLocation;
  LatLng? selectedDestinationLocation;
  final Set<Polyline> _polyline = {};

  String get startText => widget.startText;

  String get destText => widget.destText;

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
        markerId: MarkerId("0"),
        draggable: true,
        onTap: () => print(_markers.first.position),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        position: getlocation(this.startText)));
    _markers.add(Marker(
        markerId: MarkerId("1"),
        draggable: true,
        onTap: () => print("Marker!"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: getlocation(this.destText)));
    _polyline.add(Polyline(
        polylineId: PolylineId('1'),
        points: getroute(this.startText, this.destText).location,
        color: Colors.green));
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.556022, 127.044741),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    String startText = widget.startText;
    String destText = widget.destText;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff0E4A84),
          iconTheme: IconThemeData(color: Colors.white),
          //toolbarHeight: 100,
          //leadingWidth: 50,
          title: Container(
              //height: 150,
              child: SingleChildScrollView(
                  // padding: EdgeInsets.only(top: 30),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    height: 40,
                    // width: MediaQuery.of(context).size.width - 30,
                    width: MediaQuery.of(context).size.width * 0.5 - 85,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(children: [
                      Expanded(
                          child: Container(
                              child: Text(
                        '$startText',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )))
                    ])),
                Container(
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20,
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.5 - 85,
                    //width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(children: [
                      Expanded(
                          child: Container(
                              child: Text(
                                  /*controller: destinationController,
                                          initialValue: destText,*/
                                  '$destText',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white))))
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
            ])
          ]),
      endDrawer: Hamburger(),
      body: Stack(children: [
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
        SlidingUpPanel(
          controller: panelController,
          parallaxEnabled: true,
          parallaxOffset: .5,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          minHeight: 200,
          panelBuilder: (controller) => PanelWidget(
            controller: controller,
            panelController: panelController,
            RouteNumber: getroute(this.startText, this.destText).num,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        )
      ]),
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
