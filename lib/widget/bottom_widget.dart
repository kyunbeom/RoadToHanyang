import 'package:flutter/material.dart';
import 'package:road_to_hanyang/page/setting_page.dart';
import 'package:road_to_hanyang/widget/bottom/comfort_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BottomWidget extends StatefulWidget {
  final int index;

  BottomWidget({Key? key, required this.index}) : super(key: key);

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}
  class _BottomWidgetState extends State<BottomWidget> {

   final bottomController = PanelController();
   final List<Map<String, String>> _favCandidates = [
     { '출발지': '애지문', '도착지': 'itbt관'},
     { '출발지': '애지문', '도착지': '제1공학관'},
     { '출발지': 'itbt관', '도착지': '애지문'},
   ];
   //final controller = ScrollController();
   final List<Map<String, String>> _favorites =[ ];

   /*new List.empty();*/
   Widget build(BuildContext context) {
    switch (widget.index) {
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
          child: Text('이것도 준비중입니다'),
          ),
        );
      case 2:

        return SlidingUpPanel(
          controller: bottomController,
          minHeight: 170,
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          panelBuilder: (controller) => _buildFavoritesPanel(controller),
        );

      case 3:
        return Container();
      default:
        return Container();
    }
  }


   Widget _buildFavoritesPanel(ScrollController sc) {
     return ListView.builder(
         controller: sc,
         itemCount: _favCandidates.length * 2,
         itemBuilder: (BuildContext context, int index) {
           if (index.isOdd) return Divider();

           final itemIndex = index ~/ 2;
           final item = _favCandidates[itemIndex];
           final alreadySaved = _favorites.contains(_favCandidates[itemIndex]);

           return ListTile(
            title: Text(item['출발지']!),
            subtitle: Text(item['도착지']!),
            trailing: IconButton(
              icon: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
              ),
              onPressed: () {
                _toggleFavorite(index);
               },
            ),
              onTap: () {
                _toggleFavorite(index);
            },
           );
         },
     );
   }

   void _toggleFavorite(int index) {
     setState(() {
       if (_favorites.contains(_favCandidates[index])) {
         _favorites.remove(_favCandidates[index]);
       } else {
         _favorites.insert(0, _favCandidates[index]);
       }
     });
   }
  }