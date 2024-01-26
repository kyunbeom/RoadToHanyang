import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_to_hanyang/page/comforts/print_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../map_result.dart';
import '../../map_sample.dart';
import 'package:road_to_hanyang/informations/locations.dart';
import '../../widget/hamburger.dart';
import '../../widget/panel_widget.dart';

class Eat2 extends StatefulWidget {
  @override
  State<Eat2> createState() => _Eat2State();
}

class _Eat2State extends State<Eat2> {
 //  const Print2({Key? key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    final Set<Polyline> _polyline = {};

    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.556022, 127.044741),
      zoom: 15,
    );

    List<Marker> _markers = <Marker>[
      Marker(
          markerId: MarkerId("0"),
          position: HF,
          infoWindow: InfoWindow(title: "학생복지관", snippet: "3층 (학생식당)")),
      Marker(
          markerId: MarkerId("1"),
          position: HP,
          infoWindow: InfoWindow(title: "행원파크", snippet: "B1층 (행원파크식당)")),
      Marker(
          markerId: MarkerId("2"),
          position: LatLng(37.558936, 127.047101),
          infoWindow: InfoWindow(title: "제1학생생활관", snippet: "1층 (고시반 식당)")),
      Marker(
          markerId: MarkerId("3"),
          position: LatLng(37.559779, 127.049827),
          infoWindow: InfoWindow(title: "제2학생생활관식당", snippet: "1층 (제2 학생생활관 식당)")),
      Marker(
          markerId: MarkerId("4"),
          position: SG,
          infoWindow: InfoWindow(title:"생활과학관", snippet: "7층 (생활과학관 식당)")),
      Marker(
          markerId: MarkerId("5"),
          position: SSG,
          infoWindow: InfoWindow(title: "신소재공학관",snippet: "7층 (룸:112)")),
      Marker(
          markerId: MarkerId("6"),
          position: HIT,
          infoWindow: InfoWindow(title: "한양종합기술연구원(HIT)",snippet: "6층 (이십사절기 식당)")),
      Marker(
          markerId: MarkerId("7"),
          position: HIT,
          infoWindow: InfoWindow(title: "한양종합기술연구원(HIT)",snippet: "6층 (이십사절기 식당)")),
    ];
    Completer<GoogleMapController> _controller = Completer();

    return Scaffold(
        appBar: AppBar(
              backgroundColor: Color(0xff0E4A84),
              iconTheme: IconThemeData(color: Colors.white),
              toolbarHeight: 100,
              //leadingWidth: 50,
              automaticallyImplyLeading: false,
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
                                                      // focusNode: startFocusNode, // _focusNode 추가
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
                                                  // focusNode: destFocusNode, // _focusNode 추가
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
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                IconButton(
                    icon: Icon(Icons.print, color: Color(0xff0E4A84)),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Print()),
                            (route) => false, // 모든 이전 화면 흔적을 제거
                      );
                    }),
                IconButton(
                    icon: Icon(Icons.home, color: Color(0xff0E4A84)),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapSample()),
                            (route) => false, // 모든 이전 화면 흔적을 제거
                      );
                    })
              ],
            ),
          )
        ],
      )
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
    );
  }
}