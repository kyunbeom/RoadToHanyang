import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_to_hanyang/info.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'hamburger.dart';


class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}


class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  PanelController _pc = new PanelController();
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
          ),
          ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(width: 7),
                    Text("출발지"),
                    SizedBox(width: 3),
                    Container(
                        margin: EdgeInsets.all(3),
                      width:200,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                      maxLength: 30,
                      decoration: const InputDecoration(
                          counterText: '',
                          counterStyle: TextStyle(fontSize: 14),
                      ),
                    )
                    ),
                    SizedBox(width: 90),
                    Ink(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search,color: Color(0xff0E4A84),
                      ),
                    ),
                    ),
                    ]
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
                        width:200,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          maxLength: 30,
                          decoration: const InputDecoration(
                              counterText: '',
                              counterStyle: TextStyle(fontSize: 14),
                          ),
                        )
                    ),
                  SizedBox(width: 90),
    Ink(
    decoration: const ShapeDecoration(
    shape: CircleBorder(),
    color: Colors.blue,
    ),
    child: IconButton(
    onPressed: () {},
    icon: const Icon(Icons.search, color: Color(0xff0E4A84)),
    ),
    ),
                  ],
                ),
              ),
            ],
          ),

          SlidingUpPanel(
            parallaxEnabled: true,
            parallaxOffset: .5,
            controller: _pc,
            panel: Center(
              child: Container(
                child: informations(),
              ),
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            header: _buildDragHandle(),
            body: _body(),
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




