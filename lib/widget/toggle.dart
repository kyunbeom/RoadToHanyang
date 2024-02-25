import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PathToggle extends StatefulWidget {
  final String title;
  final Widget content;

  PathToggle({
    required this.title,
    required this.content,
  });

  @override
  State<PathToggle> createState() => _PathToggleState();
}

class _PathToggleState extends State<PathToggle> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Row(children: [
                //TODO: 화살표 방향
                _isExpanded
                    ? Transform.rotate(
                        angle: 90 * 3.14159265 / 180, // 90도를 라디안으로 변환
                        child: Icon(Icons.play_arrow_rounded,
                            color: Color(0xff6B6B6B), size: 18))
                    : Icon(Icons.play_arrow_rounded,
                        color: Color(0xff6B6B6B), size: 18),
                SizedBox(width: 11),
                Text(
                  widget.title,
                  style: TextStyle(
                      color: Color(0xff6B6B6B),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                )
              ])),
          if (_isExpanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: widget.content,
            ),
        ]));
  }
}
