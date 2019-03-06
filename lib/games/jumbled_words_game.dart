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
          calculateLayout: BentoBox.calculateCustomizedLayout,
    );
  }
}
