import 'package:flutter/material.dart';
import 'package:jamaica/bento_box.dart';
import 'package:jamaica/cute_button.dart';

class _ChoiceDetail {
  int choice;
  Reaction reaction;
  _ChoiceDetail({this.choice, this.reaction});
}

class SequenceTheNumberGame extends StatefulWidget {
  final List<int> sequence;
  final List<int> choices;
  final int blankPosition;

  const SequenceTheNumberGame(
      {Key key, this.sequence, this.choices, this.blankPosition})
      : super(key: key);

  @override
  _SequenceTheNumberGameState createState() => _SequenceTheNumberGameState();
}

class _SequenceTheNumberGameState extends State<SequenceTheNumberGame> {
  List<_ChoiceDetail> choiceDetails;
  List<_ChoiceDetail> questionDetails;

  @override
  void initState() {
    super.initState();
    questionDetails = widget.sequence
        .map((s) => _ChoiceDetail(
              choice: s,
              reaction: Reaction.success,
            ))
        .toList(growable: false);
    choiceDetails = widget.choices
        .map((c) => _ChoiceDetail(
              choice: c,
              reaction: Reaction.success,
            ))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return BentoBox(
      qRows: 1,
      qCols: questionDetails.length,
      qChildren: questionDetails
          .map((c) => CuteButton(
                child: Center(
                  child: Text(c.choice.toString()),
                ),
              ))
          .toList(growable: false),
      rows: 1,
      cols: choiceDetails.length,
      children: choiceDetails
          .map((c) => CuteButton(
                child: Center(
                  child: Text(c.choice.toString()),
                ),
                reaction: c.reaction,
              ))
          .toList(growable: false),
    );
  }
}
