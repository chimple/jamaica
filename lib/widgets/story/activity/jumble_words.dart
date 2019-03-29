import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/games/jumbled_words_game.dart';
import 'package:jamaica/widgets/bento_box.dart';
import 'package:jamaica/widgets/cute_button.dart';

TextStyle textStyle({double fSize = 25, color: Colors.red}) =>
    TextStyle(fontSize: fSize, fontFamily: 'Bungee', color: color, shadows: [
      Shadow(
        blurRadius: 3.0,
        color: Colors.black,
      )
    ]);

class _ChoiceDetail {
  String choice;
  int index;
  bool appear;

  _ChoiceDetail({this.choice, this.appear = true, this.index});
  @override
  String toString() =>
      '_ChoiceDetail(choice: $choice, appear: $appear,index: $index, )';
}

class JumbleWords extends StatefulWidget {
  const JumbleWords({
    Key key,
  }) : super(key: key);

  @override
  _JumbleWordsState createState() => _JumbleWordsState();
}

class _JumbleWordsState extends State<JumbleWords> {
  List<_ChoiceDetail> choiceDetails;
  List<_ChoiceDetail> answerDetails;
  final BuiltList<String> choices =
      BuiltList<String>(["He", 'Like', 'to', 'tease', 'peaope']);
  final BuiltList<String> answers =
      BuiltList<String>(["He", 'Like', 'to', 'tease', 'peaope']);
  List<List<String>> addToBox = [];
  int complete, score = 0;
  List<bool> _colorStatus = [];
  @override
  void initState() {
    super.initState();
    int i = 0;
    int j = 0;
    choiceDetails = choices
        .map((c) => _ChoiceDetail(choice: c, index: i++))
        .toList(growable: false);
    complete = choiceDetails.length;
    answerDetails = answers
        .map((a) => _ChoiceDetail(choice: a, appear: false, index: j++))
        .toList(growable: false);
    for (int k = 0; k < answerDetails.length; k++) {
      addToBox.add([]);
      _colorStatus.add(true);
    }
  }

  Widget _dragTarget(String s, int index, bool c) {
    return DragTarget<String>(
        // key: Key('answer'),
        onAccept: (a) {
          if (a == s) {
            setState(() {
              answerDetails[choices.indexOf(a)].appear = true;
              choiceDetails[choices.indexOf(a)].appear = false;
            });

            print('onaccept ${choices.indexOf(a)}, $answerDetails');
          }
        },
        onLeave: (s) {},
        onWillAccept: (data) {
          return data == s ? true : false;
        },
        builder: (context, list, er) {
          return Container(
            child: Text(
              s,
              style: textStyle(color: !c ? Colors.red[50] : Colors.red),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Wrap(
          spacing: 20,
          children: answerDetails
              .map((s) => _dragTarget(s.choice, index++, s.appear))
              .toList(),
        ),
        BentoBox(
          calculateLayout: BentoBox.calculateOrderlyRandomizedLayout,
          dragConfig: DragConfig.draggableBounceBack,
          rows: 2,
          cols: 5,
          children: choiceDetails
              .map((c) => c.appear
                  ? CuteButton(
                      cuteButtonType: CuteButtonType.text,
                      key: Key("${(c.choice)}"),
                      child: Material(
                          color: Colors.transparent,
                          child: Text(c.choice,
                              style: textStyle(color: Colors.red))))
                  : Container(
                      key: Key("${(index).toString()}"),
                    ))
              .toList(growable: false),
        )
      ],
    );
  }
}
