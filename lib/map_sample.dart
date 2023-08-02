import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_to_hanyang/info.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'hamburger.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  TextEditingController startController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  PanelController _pc = new PanelController();
  List<String> suggestons = ["제 1공학관", "제 2공학관", "itbt관", "행원파크", "공업센터"];

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
                child: Row(children: [
                  SizedBox(width: 7),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.all(3),
                        width: 200,
                        child: TypeAheadField(
                          animationStart: 0,
                          animationDuration: Duration.zero,
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: startController,
                              autofocus: true,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  hintText: "출발지를 입력해주세요",
                                  border: OutlineInputBorder())
                                 ),
                          suggestionsBoxDecoration: SuggestionsBoxDecoration(
                              color: Colors.lightBlue[50]),
                          suggestionsCallback: (pattern) {
                            List<String> matches = <String>[];
                            matches.addAll(suggestons);

                            matches.retainWhere((s) {
                              return s
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase());
                            });
                            return matches;
                          },
                          itemBuilder: (context, sone) {
                            return Card(
                                child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(sone.toString()),
                            ));
                          },
                          onSuggestionSelected: (suggestion) {
                            startController.text = suggestion;
                          },
                        )),
                  ),

                ]),
              ),
              Container(
                margin: EdgeInsets.all(5),
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(width: 7),
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.all(3),
                          width: 200,
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
                                    border: OutlineInputBorder())),
                            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                color: Colors.lightBlue[50]),
                            suggestionsCallback: (pattern) {
                              List<String> matches = <String>[];
                              matches.addAll(suggestons);

                              matches.retainWhere((s) {
                                return s
                                    .toLowerCase()
                                    .contains(pattern.toLowerCase());
                              });
                              return matches;
                            },
                            itemBuilder: (context, sone) {
                              return Card(
                                  child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(sone.toString()),
                              ));
                            },
                            onSuggestionSelected: (suggestion) {
                              destinationController.text = suggestion;
                            },
                          )),
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
                child: informations(context),
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
