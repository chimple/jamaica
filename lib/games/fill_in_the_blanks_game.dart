import 'package:flutter/material.dart';
import 'package:jamaica/widgets/bento_box.dart';
import 'package:jamaica/widgets/cute_button.dart';
import 'package:jamaica/widgets/drop_box.dart';
import 'package:tuple/tuple.dart';

class _QuestionDetail {
  String choice;
  Reaction reaction;
  bool appear;

  _QuestionDetail(
      {this.choice, this.appear = true, this.reaction = Reaction.success});
  @override
  String toString() =>
      '_QuestionDetail(choice: $choice, appear: $appear, reaction: $reaction)';
}

class FillInTheBlanksGame extends StatefulWidget {
  final List<Tuple2<String, String>> data;

  const FillInTheBlanksGame({Key key, this.data}) : super(key: key);

  @override
  _FillInTheBlanksGameState createState() => _FillInTheBlanksGameState();
}

class _FillInTheBlanksGameState extends State<FillInTheBlanksGame> {
  List<_QuestionDetail> questionDetails = [];
  List<String> dragBoxData = [];

  @override
  void initState() {
    super.initState();
    dragBoxData = widget.data.map((f) => f.item2).toList(growable: false)
      ..shuffle();
    for (int p = 0; p < widget.data.length; p++) {
      questionDetails.add(_QuestionDetail(
        choice: widget.data[p].item1 == ''
            ? widget.data[p].item2
            : widget.data[p].item1,
        appear: widget.data[p].item1 == '' ? false : true,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return BentoBox(
      rows: 1,
      cols: widget.data.length,
      children: dragBoxData
          .map((c) => CuteButton(
                key: Key(c + (i++).toString()),
                child: Center(child: Text(c)),
              ))
          .toList(growable: false),
      qRows: 1,
      qCols: widget.data.length,
      qChildren: questionDetails
          .map((f) => f.appear
              ? CuteButton(
                  key: Key((i++).toString()),
                  child: Center(child: Text(f.choice)),
                )
              : DropBox(
                  key: Key((i++).toString()),
                  child: CuteButton(
                    child: Center(child: Text('_')),
                  ),
                  onWillAccept: (data) => data.substring(0, 1) == f.choice,
                  onAccept: (data) => setState(() => f.appear = true),
                ))
          .toList(growable: false),
      dragConfig: DragConfig.draggableMultiPack,
    );
  }
}
