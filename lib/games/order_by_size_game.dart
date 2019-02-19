import 'package:flutter/material.dart';
import 'package:jamaica/widgets/bento_box.dart';
import 'package:jamaica/widgets/cute_button.dart';

class _ChoiceDetail {
  int number;
  Reaction reaction;
  _Type type;

  _ChoiceDetail({
    this.number,
    this.type = _Type.choice,
    this.reaction = Reaction.success,
  });
  @override
  String toString() =>
      '_ChoiceDetail(choice: $number, type: $type, reaction: $reaction)';
}

enum _Type { choice, answer }

class OrderBySizeGame extends StatefulWidget {
  final List<int> answers;
  final List<int> choices;

  const OrderBySizeGame({Key key, this.answers, this.choices})
      : super(key: key);

  @override
  _OrderBySizeGameState createState() => _OrderBySizeGameState();
}

class _OrderBySizeGameState extends State<OrderBySizeGame> {
  List<_ChoiceDetail> choiceDetails;
  List<_ChoiceDetail> answerDetails;

  @override
  void initState() {
    super.initState();
    int i = 0;
    choiceDetails = widget.choices
        .map((c) => _ChoiceDetail(number: c))
        .toList(growable: false);
    answerDetails = widget.answers
        .map((c) => choiceDetails.firstWhere((d) => d.number == c))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return BentoBox(
      dragConfig: DragConfig.draggableBounceBack,
      rows: 1,
      cols: choiceDetails.length,
      children: choiceDetails
          .map((c) => c.type == _Type.choice
              ? CuteButton(
                  key: Key(c.number.toString()),
                  child: Center(child: Text(c.number.toString())),
                )
              : Container())
          .toList(growable: false),
      qRows: 1,
      qCols: answerDetails.length,
      qChildren: answerDetails
          .map((a) => a.type == _Type.choice
              ? DragTarget<String>(
                  key: Key('choice_${a.number}'),
                  builder: (context, candidateData, rejectedData) => Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                      ),
                  onWillAccept: (data) {
                    return data == a.number.toString();
                  },
                  onAccept: (data) => WidgetsBinding.instance
                      .addPostFrameCallback(
                          (_) => setState(() => a.type = _Type.answer)),
                )
              : CuteButton(
                  key: Key(a.number.toString()),
                  child: Center(child: Text(a.number.toString())),
                ))
          .toList(growable: false),
    );
  }
}
