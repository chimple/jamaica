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

class SequenceAlphabetGame extends StatefulWidget {
  final List<String> answers;

  const SequenceAlphabetGame({Key key, this.answers}) : super(key: key);

  @override
  _SequenceAlphabetGameState createState() => _SequenceAlphabetGameState();
}

class _SequenceAlphabetGameState extends State<SequenceAlphabetGame> {
  List<_ChoiceDetail> choiceDetails;

  @override
  void initState() {
    super.initState();
    int i = 0;
    choiceDetails = widget.answers
        .map((a) => _ChoiceDetail(choice: a, index: i++))
        .toList()
          ..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return BentoBox(
      dragConfig: DragConfig.draggableBounceBack,
      cols: choiceDetails.length,
      rows: 1,
      children: choiceDetails
          .map((c) => DragTarget<String>(
                key: Key(c.index.toString()),
                builder: (context, candidateData, rejectedData) => CuteButton(
                      child: Center(child: Text(c.choice)),
                    ),
                onWillAccept: (data) => true,
                onAccept: (data) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => setState(() {
                            int currentIndex = choiceDetails.indexWhere((ch) =>
                                ch.index.toString() == c.index.toString());
                            int droppedIndex = choiceDetails.indexWhere(
                                (ch) => ch.index.toString() == data);
                            final droppedChoice = choiceDetails[droppedIndex];
                            choiceDetails.removeAt(droppedIndex);
                            choiceDetails.insert(currentIndex, droppedChoice);
                          }));
                },
              ))
          .toList(growable: false),
    );
  }
}
