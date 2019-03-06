import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jamaica/widgets/bento_box.dart';
import 'package:jamaica/widgets/cute_button.dart';

class _ChoiceDetail {
  String choice;
  Reaction reaction;
  _Type type;
  bool solved;

  _ChoiceDetail({
    this.choice,
    this.type = _Type.choice,
    this.reaction = Reaction.success,
    this.solved = false,
  });
  @override
  String toString() =>
      '_ChoiceDetail(choice: $choice, type: $type, solved: $solved, reaction: $reaction)';
}

enum _Type { choice, question }

class JumbledWordsGame extends StatefulWidget {
  final String answer;
  final List<String> choices;

  const JumbledWordsGame({Key key, this.answer, this.choices})
      : super(key: key);

  @override
  _JumbledWordsGameState createState() => _JumbledWordsGameState();
}

class _JumbledWordsGameState extends State<JumbledWordsGame> {
  List<_ChoiceDetail> choiceDetails;
  bool thisSolved = false;

  @override
  void initState() {
    super.initState();
    choiceDetails = widget.choices
        .map((c) => _ChoiceDetail(choice: c))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> frontChildren;
    if (thisSolved) {
      frontChildren = choiceDetails
          .where((c) => c.solved == true)
          .map((c) => CuteButton(
                key: Key(c.choice),
                child: Center(child: Text(c.choice)),
              ) as Widget)
          .toList();
      frontChildren.add(Center(key: Key('answer'), child: Text(widget.answer)));
    }

    return BentoBox(
      dragConfig: DragConfig.draggableBounceBack,
      frontChildren: frontChildren,
      qRows: 1,
      qCols: 1,
      qChildren: thisSolved
          ? <Widget>[Container()]
          : <Widget>[
              DragTarget<String>(
                key: Key('answer'),
                builder: (context, candidateData, rejectedData) =>
                    Center(child: Text(widget.answer)),
                onWillAccept: (data) => data == widget.answer,
                onAccept: (data) => WidgetsBinding.instance
                    .addPostFrameCallback((_) => setState(() {
                          choiceDetails
                              .firstWhere((c) => c.choice == data)
                              .solved = true;
                          thisSolved = true;
                        })),
              )
            ],
      rows: 1,
      cols: choiceDetails.length,
      children: choiceDetails
          .map((c) => c.solved
              ? Container()
              : CuteButton(
                  key: Key(c.choice),
                  child: Center(child: Text(c.choice)),
                ))
          .toList(growable: false),
      calculateLayout: calculateCustomizedLayout,
    );
  }

  static calculateCustomizedLayout(
      {int cols,
      int rows,
      List<Widget> children,
      int qCols,
      int qRows,
      List<Widget> qChildren,
      Map<Key, BentoChildDetail> childrenMap,
      Size size}) {
    final allRows = rows + qRows;
    final allCols = max(cols, qCols);
    final childWidth = size.width / allCols;
    final childHeight = size.height / allRows;
    print(
        "this my new width ${size.width} and new height ${size.height} and child width is $childWidth and $childHeight and rows $allRows colmun $allCols");
    int i = 0;

    Offset center = Offset((qCols + (i ~/ qRows)) * (childWidth) * 1.5,
        ((allRows - qRows) / 2 + (i++ % qRows)) * childHeight);
    i = 0;
    (qChildren ?? []).forEach((c) => childrenMap[c.key] = BentoChildDetail(
          child: c,
          offset: center,
        ));

    double j = 0;
    double k = 2 * pi / children.length;
    children.forEach((f) {
      childrenMap[f.key] = BentoChildDetail(
        child: f,
        offset: Offset((center.dx + childWidth * 1.2 * (cos(j).toInt())),
            (center.dy + childHeight * .5 * (sin(j).toInt()))),
      );
      j = j + k;
    });
  }
}
