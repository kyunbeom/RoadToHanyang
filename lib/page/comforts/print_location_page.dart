import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../map_sample.dart';
import '../../widget/panel_widget.dart';

class Print2 extends StatelessWidget {
  const Print2({Key? key}) : super(key: key);

  get panelController => null;

  @override
  Widget build(BuildContext context) {
    final Set<Polyline> _polyline = {};

    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.556022, 127.044741),
      zoom: 15,
    );

    List<Marker> _markers = <Marker>[
      Marker(markerId: MarkerId("0"), position: LatLng(37.555903, 127.049331),
    infoWindow: InfoWindow(snippet: "ITBT관 x층")),
      Marker(markerId: MarkerId("1"), position: LatLng(37.556623, 127.045629),
          infoWindow: InfoWindow(snippet: "제 1공학관 x층")),
    ];
    Completer<GoogleMapController> _controller = Completer();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff0E4A84),
            iconTheme: IconThemeData(color: Colors.white),
            title: Center(
                child: Text('복사실', style: TextStyle(color: Colors.white))),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => MapSample()));
                    // Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MapSample()),
                          (route) => false, // 모든 이전 화면 흔적을 제거
                    );
                  })
            ]),
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

   /* // TODO: 이게 맵 위에 있도록 해야함
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
    )*/
    ])
    );} }