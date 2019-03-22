import 'package:flutter/material.dart';

class DragTextActivity extends StatefulWidget {
  @override
  _DragTextState createState() => new _DragTextState();
}

class _DragTextState extends State<DragTextActivity> {
  final List<String> list = [
    "tiget",
    "cloud",
    "building",
    "tree",
    "hospital",
    "building",
    "tree",
    "hospital"
  ];
  double textSize;
  @override
  initState() {
    super.initState();
    list.sort((a, b) => a.length.compareTo(b.length));
  }

  Widget _build(String s) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(12)),
      height: textSize + 10,
      width: s.length.toDouble() * textSize * .6,
      child: Center(
        child: Text(
          s,
          style: TextStyle(fontSize: textSize),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    textSize = MediaQuery.of(context).orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width * .065
        : MediaQuery.of(context).size.height * .065;
    print('textSize $textSize');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'Drag and drop the text to their relevant image',
            style: TextStyle(fontSize: 23),
          ),
          Wrap(
              runAlignment: WrapAlignment.spaceAround,
              verticalDirection: VerticalDirection.down,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: list
                  .map((s) => Draggable(
                        feedback: Material(
                          color: Colors.transparent,
                          child: _build(s),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: _build(s),
                        ),
                        childWhenDragging: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: _build(s),
                        ),
                      ))
                  .toList()),
        ],
      ),
    );
  }
}
