import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/state/game_utils.dart';
import 'package:jamaica/widgets/bento_box.dart';
import 'package:jamaica/widgets/cute_button.dart';
import 'package:jamaica/widgets/dot_number.dart';

class _ChoiceDetail {
  int number;
  Reaction reaction;

  _ChoiceDetail({this.number, this.reaction = Reaction.enter});
  @override
  String toString() => '_ChoiceDetail(choice: $number, reaction: $reaction)';
}

class FingerGame extends StatefulWidget {
  final int answer;
  final BuiltList<int> choices;
  final OnGameOver onGameOver;

  const FingerGame({Key key, this.answer, this.choices, this.onGameOver})
      : super(key: key);

  @override
  _FingerGameState createState() => _FingerGameState();
}

class _FingerGameState extends State<FingerGame> {
  List<int> fingers;
  List<_ChoiceDetail> choiceDetails;

  @override
  void initState() {
    super.initState();
    fingers = widget.answer > 5 ? [5, widget.answer - 5] : [widget.answer];
    choiceDetails = widget.choices
        .map((c) => _ChoiceDetail(number: c))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Row(
            children:
                fingers.map((f) => Text(f.toString())).toList(growable: false),
          ),
        ),
        Flexible(
          flex: 1,
          child: BentoBox(
            rows: 1,
            cols: choiceDetails.length,
            children: choiceDetails
                .map((c) => CuteButton(
                      key: Key(c.number.toString()),
                      child: DotNumber(
                        number: c.number,
                        showNumber: true,
                      ),
                      reaction: c.reaction,
                      onPressed: () {
                        setState(() => c.reaction = (c.number == widget.answer)
                            ? Reaction.success
                            : Reaction.failure);
                      },
                    ))
                .toList(growable: false),
          ),
        )
      ],
    );
  }
}
