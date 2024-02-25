import 'package:flutter/material.dart';
import 'package:road_to_hanyang/page/setting_page.dart';
import 'package:road_to_hanyang/widget/bottom/comfort_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BottomWidget extends StatelessWidget {
  final int index;
  final bottomController = PanelController();
  //final controller = ScrollController();

  BottomWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return SlidingUpPanel(
          controller: bottomController,
          minHeight: 170,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          panelBuilder: (controller) => ComfortWidget(
            controller: controller,
            bottomController: bottomController,
          ),
        );
      case 1:
        return SlidingUpPanel(
          controller: bottomController,
          minHeight: 170,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          panel: Container(
            child: Text('aedf'),
          ),
        );
      case 2:
        return SlidingUpPanel(
          controller: bottomController,
          minHeight: 170,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          panel: Container(
            child: Text('aedf'),
          ),
        );
      case 3:
        return Container();
      default:
        return Container();
    }
  }
}
