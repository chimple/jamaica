import 'package:flutter/material.dart';
import 'package:jamaica/widgets/bento_box.dart';
import 'package:jamaica/widgets/cute_button.dart';

class _ChoiceDetail {
  String choice;
  Reaction reaction;
  int index;

  _ChoiceDetail({this.choice, this.reaction = Reaction.success, this.index});
  @override
  String toString() =>
      '_ChoiceDetail(choice: $choice, reaction: $reaction, index: $index)';
}

class TrueFalseGame extends StatefulWidget {
  final List<String> questions;
  final List<String> answers;
  final List<String> choices;
  final bool right_or_wrong;

  const TrueFalseGame(
      {Key key,
      this.questions,
      this.answers,
      this.choices,
      this.right_or_wrong})
      : super(key: key);

  @override
  _RhymeWordsGameState createState() => _RhymeWordsGameState();
}

class _RhymeWordsGameState extends State<TrueFalseGame> {
  List<_ChoiceDetail> choiceDetails;

  @override
  void initState() {
    super.initState();
    int i = 0;
    choiceDetails = widget.choices
        .map((a) => _ChoiceDetail(choice: a, index: ++i))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return BentoBox(
      axis: Axis.vertical,
      qCols: widget.questions.length,
      qRows: 2,
      qChildren: widget.questions
          .map((q) => CuteButton(
                key: Key(q),
                child: Center(child: Text(q)),
              ) as Widget)
          .toList()
            ..addAll(widget.answers.map((q) => CuteButton(
                  key: Key('$q 1'),
                  child: Center(child: Text(q)),
                ) as Widget)),
      cols: choiceDetails.length,
      rows: 1,
      children: choiceDetails
          .map((c) => CuteButton(
                key: Key(c.choice),
                reaction: c.reaction,
                child: Center(
                    child: Icon(
                  c.choice == "Right" ? Icons.check : Icons.close,
                  color: c.choice == "Right" ? Colors.green : Colors.red,
                )),
                onPressed: () {
                  if (widget.right_or_wrong && c.choice == "Right") {
                    c.reaction = Reaction.success;
                  }
                  if (!widget.right_or_wrong && c.choice == "Wrong") {
                    c.reaction = Reaction.success;
                  } else {
                    c.reaction = Reaction.failure;
                  }
                },
              ))
          .toList(growable: false),
    );
  }
}
