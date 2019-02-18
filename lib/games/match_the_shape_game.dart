import 'package:flutter/material.dart';
import 'package:jamaica/widgets/animated_scale.dart';
import 'package:jamaica/widgets/bento_box.dart';
import 'package:jamaica/widgets/cute_button.dart';

class _ChoiceDetail {
  String choice;
  String type;
  Reaction reaction;
  _Escape escape;
  _ChoiceDetail(
      {this.choice,
      this.type,
      this.reaction = Reaction.success,
      this.escape = _Escape.no});
  @override
  String toString() =>
      '_ChoiceDetail(choice: $choice, type: $type, reaction: $reaction, escape: $escape)';
}

enum _Escape { no, escaping, escaped }

class MatchTheShapeGame extends StatefulWidget {
  final List<String> first;
  final List<String> second;

  const MatchTheShapeGame({Key key, this.first, this.second}) : super(key: key);

  @override
  _MatchTheShapeGameState createState() => _MatchTheShapeGameState();
}

class _MatchTheShapeGameState extends State<MatchTheShapeGame> {
  List<_ChoiceDetail> choiceDetails;

  @override
  void initState() {
    super.initState();
    choiceDetails = widget.first
        .map((c) => _ChoiceDetail(choice: c, type: 'first'))
        .toList();
    choiceDetails.addAll(
        widget.second.map((c) => _ChoiceDetail(choice: c, type: 'second')));
  }

  @override
  Widget build(BuildContext context) {
    return BentoBox(
      randomize: true,
      dragConfig: DragConfig.draggableNoBounceBack,
      rows: 3,
      cols: widget.first.length,
      children: choiceDetails
          .map((c) => c.escape == _Escape.no
              ? DragTarget<String>(
                  key: Key('${c.choice}_${c.type}'),
                  builder: (context, candidateData, rejectedData) => CuteButton(
                        child: Center(
                          child: Text(c.choice),
                        ),
                        onPressed: () => Reaction.success,
                      ),
                  onWillAccept: (data) => data.split('_').first == c.choice,
                  onAccept: (data) => setState(() {
                        choiceDetails
                            .where((choice) => c.choice == choice.choice)
                            .forEach((choice) {
                          WidgetsBinding.instance.addPostFrameCallback((_) =>
                              setState(() => choice.escape = _Escape.escaping));
                          Future.delayed(
                              Duration(milliseconds: 1000),
                              () => setState(
                                  () => choice.escape = _Escape.escaped));
                        });
                      }),
                )
              : Container())
          .toList(growable: false),
      frontChildren: choiceDetails
          .where((c) => c.escape == _Escape.escaping)
          .map((c) => CuteButton(
                key: Key('${c.choice}_${c.type}'),
                child: Center(
                  child: Text(c.choice),
                ),
                onPressed: () => Reaction.success,
              ))
          .toList(growable: false),
    );
  }
}
