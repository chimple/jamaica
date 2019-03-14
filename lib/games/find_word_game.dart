import 'package:flutter/material.dart';
import 'package:jamaica/widgets/bento_box.dart';
import 'package:jamaica/widgets/cute_button.dart';

class _ChoiceDetail {
  String letter;
  Reaction reaction;

  _ChoiceDetail({this.letter, this.reaction = Reaction.success});
  @override
  String toString() => '_ChoiceDetail(choice: $letter, reaction: $reaction)';
}

class FindWordGame extends StatefulWidget {
  final String image;
  final List<String> answer;
  final List<String> choices;

  const FindWordGame({Key key, this.image, this.answer, this.choices})
      : super(key: key);

  @override
  _FindWordGameState createState() => _FindWordGameState();
}

class _FindWordGameState extends State<FindWordGame> {
  List<_ChoiceDetail> choiceDetails;
  List<String> word = [];

  @override
  void initState() {
    super.initState();
    choiceDetails = widget.choices
        .map((c) => _ChoiceDetail(letter: c))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Image.asset(widget.image),
        ),
        Flexible(
          flex: 1,
          child: Text(word.join()),
        ),
        Flexible(
          flex: 1,
          child: BentoBox(
            rows: 2,
            cols: choiceDetails.length ~/ 2,
            children: choiceDetails
                .map((c) => CuteButton(
                      key: Key(c.letter),
                      reaction: c.reaction,
                      child: Center(child: Text(c.letter)),
                      onPressed: () {
                        if (c.letter == widget.answer[word.length]) {
                          setState(() {
                            c.reaction = Reaction.success;
                            word.add(c.letter);
                          });
                        } else {
                          c.reaction = Reaction.failure;
                        }
                      },
                    ))
                .toList(growable: false),
          ),
        )
      ],
    );
  }
}
