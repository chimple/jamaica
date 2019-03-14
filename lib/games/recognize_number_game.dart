import 'package:flutter/material.dart';
import 'package:jamaica/widgets/audio_widget.dart';
import 'package:jamaica/widgets/bento_box.dart';
import 'package:jamaica/widgets/cute_button.dart';
import 'package:jamaica/widgets/dot_number.dart';

class _ChoiceDetail {
  int number;
  Reaction reaction;

  _ChoiceDetail({this.number, this.reaction = Reaction.success});
  @override
  String toString() => '_ChoiceDetail(choice: $number, reaction: $reaction)';
}

class RecognizeNumberGame extends StatefulWidget {
  final int answer;
  final List<int> choices;

  const RecognizeNumberGame({Key key, this.answer, this.choices})
      : super(key: key);

  @override
  _RecognizeNumberGameState createState() => _RecognizeNumberGameState();
}

class _RecognizeNumberGameState extends State<RecognizeNumberGame> {
  List<_ChoiceDetail> choiceDetails;

  @override
  void initState() {
    super.initState();
    choiceDetails = widget.choices
        .map((c) => _ChoiceDetail(number: c))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return BentoBox(
      qRows: 1,
      qCols: 1,
      qChildren: <Widget>[
        AudioWidget(
          word: widget.answer.toString(),
          play: true,
        )
      ],
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
    );
  }
}
