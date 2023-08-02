import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'hamburger.dart';

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

class JiwonMap extends StatefulWidget {
  @override
  State<JiwonMap> createState() => JiwonMapState();
}

class JiwonMapState extends State<JiwonMap> {
  Completer<GoogleMapController> _controller = Completer();
  PanelController _pc = new PanelController();

  List<Marker> _markers = [];
  final Set<Polyline> _polyline = {};

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
    _polyline.add(Polyline(
      polylineId: PolylineId('1'),
      points: route1,
      color: Colors.green,
    ));
  }

  // 내 위치 받아오기 함수
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
      appBar: AppBar(
        title: Text('test'),
      ),
      endDrawer: hamburger(),
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
          ),
          SlidingUpPanel(
            parallaxEnabled: true,
            parallaxOffset: .5,
            controller: _pc,
            panel: Center(
              child: Text("This is the sliding Widget"),
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            header: _buildDragHandle(),
            body: _body(),
          ),
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

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  Widget _buildDragHandle() {
    return Container(
      alignment: Alignment.center,
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

  @override
  void initState() {
    super.initState();
    animationController = BottomSheet.createAnimationController(this);
    animationController
      ..addListener(() {
        print(
            'listen : ${animationController.value}, : ${animationController.status}');
      })
      ..duration = const Duration(milliseconds: 500)
      ..reverseDuration = const Duration(milliseconds: 500);
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
        body: _body(),
      ),
    );
  }

  Widget _buildDragHandle() {
    return Align(
      alignment: Alignment.center,
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

  Widget _body() {
    return Container(
      child: Column(
        children: <Widget>[
          button(
            text: "Show",
            onPressed: () => _pc.show(),
          ),
          button(
            text: "Hide",
            onPressed: () => _pc.hide(),
          ),
        ],
      ),
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
