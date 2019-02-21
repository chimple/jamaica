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

class RhymeWordsGame extends StatefulWidget {
  final List<String> questions;
  final List<String> answers;

  const RhymeWordsGame({Key key, this.questions, this.answers})
      : super(key: key);

  @override
  _RhymeWordsGameState createState() => _RhymeWordsGameState();
}

class _RhymeWordsGameState extends State<RhymeWordsGame> {
  List<_ChoiceDetail> choiceDetails;

  @override
  void initState() {
    super.initState();
    int i = 0;
    choiceDetails = widget.answers
        .map((a) => _ChoiceDetail(choice: a, index: ++i))
        .toList(growable: false)
          ..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return BentoBox(
      dragConfig: DragConfig.draggableBounceBack,
      qCols: widget.questions.length,
      qRows: 1,
      qChildren: widget.questions
          .map((q) => CuteButton(
                key: Key(q),
                child: Center(child: Text(q)),
              ))
          .toList(growable: false),
      cols: choiceDetails.length,
      rows: 1,
      children: choiceDetails
          .map((c) => DragTarget<String>(
              key: Key(c.choice),
              builder: (context, candidateData, rejectedData) => CuteButton(
                    child: Center(child: Text(c.choice)),
                  ),
              onWillAccept: (data) {
                int currentIndex =
                    choiceDetails.indexWhere((ch) => ch.choice == c.choice);
                int dataIndex = widget.answers.indexWhere((a) => a == data);
                return dataIndex == currentIndex;
              },
              onAccept: (data) => WidgetsBinding.instance.addPostFrameCallback(
                    (_) => setState(() {
                          print(data);
                          int currentIndex = choiceDetails
                              .indexWhere((ch) => ch.choice == c.choice);
                          int dataIndex =
                              choiceDetails.indexWhere((a) => a.choice == data);
                          print('$currentIndex $dataIndex');
                          final current = choiceDetails[currentIndex];
                          choiceDetails[currentIndex] =
                              choiceDetails[dataIndex];
                          choiceDetails[dataIndex] = current;
                        }),
                  )))
          .toList(growable: false),
    );
  }
}