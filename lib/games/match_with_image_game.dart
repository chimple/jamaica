import 'package:flutter/material.dart';
import 'package:jamaica/widgets/bento_box.dart';
import 'package:jamaica/widgets/cute_button.dart';
import 'package:jamaica/widgets/drop_box.dart';

class _ChoiceDetail {
  String choice;
  Reaction reaction;
  bool appear;

  _ChoiceDetail(
      {this.choice, this.appear = true, this.reaction = Reaction.success});
  @override
  String toString() =>
      '_ChoiceDetail(choice: $choice, appear: $appear, reaction: $reaction)';
}

class MatchWithImageGame extends StatefulWidget {
  final List<String> images;
  final List<String> answers;
  final List<String> choices;

  const MatchWithImageGame({Key key, this.images, this.answers, this.choices})
      : super(key: key);

  @override
  _MatchWithImageGameState createState() => _MatchWithImageGameState();
}

class _MatchWithImageGameState extends State<MatchWithImageGame> {
  List<_ChoiceDetail> answerDetails;
  List<_ChoiceDetail> choiceDetails;

  @override
  void initState() {
    super.initState();
    choiceDetails = widget.choices
        .map((c) => _ChoiceDetail(choice: c))
        .toList(growable: false);
    answerDetails = widget.answers
        .map((a) => _ChoiceDetail(choice: a, appear: false))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return BentoBox(
      rows: 1,
      cols: choiceDetails.length,
      children: choiceDetails
          .map((c) => c.appear
              ? CuteButton(
                  key: Key(c.choice),
                  child: Center(child: Text(c.choice)),
                )
              : Container())
          .toList(growable: false),
      qRows: 2,
      qCols: answerDetails.length,
      qChildren: widget.images
          .map((img) => Image.asset(
                img,
                key: Key(img),
              ) as Widget)
          .toList()
            ..addAll(answerDetails.map((a) => DropBox(
                  key: Key((i++).toString()),
                  child: a.appear
                      ? CuteButton(
                          child: Center(child: Text(a.choice)),
                        )
                      : null,
                  onWillAccept: (data) => data == a.choice,
                  onAccept: (data) => setState(() {
                        a.appear = true;
                        choiceDetails
                            .firstWhere((c) => c.choice == a.choice)
                            .appear = false;
                      }),
                ))),
      dragConfig: DragConfig.draggableBounceBack,
    );
  }
}
