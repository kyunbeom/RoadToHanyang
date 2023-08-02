import 'package:flutter/material.dart';

class PathToggle extends StatefulWidget {
  final String title;
  final Widget content;

  PathToggle({required this.title, required this.content});

  @override
  State<PathToggle> createState() => _PathToggleState();
}

class _PathToggleState extends State<PathToggle> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            children: [
              Icon(
                _isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                color: Colors.black,
                size: 25.0,
              ),
              Text(
                widget.title,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ],
          ),
        ),
        if (_isExpanded)
          Container(
            padding: EdgeInsets.only(left: 25.0, top: 5.0),
            child: widget.content,
          ),
      ],
    );
  }
}
