import 'package:flutter/material.dart';
import 'package:jamaica/widgets/bento_box.dart';
import 'package:jamaica/widgets/cute_button.dart';

class _ChoiceDetail {
  String choice;
  Reaction reaction;
  int index;
  bool appear;

  _ChoiceDetail({this.choice, this.appear = true, this.index});
  @override
  String toString() =>
      '_ChoiceDetail(choice: $choice, appear: $appear,index: $index, )';
}

class MatchTheBoxGame extends StatefulWidget {
  final List<String> choices;
  final List<String> answers;

  const MatchTheBoxGame({
    Key key,
    this.choices,
    this.answers,
  }) : super(key: key);

  @override
  _MatchTheBoxGameState createState() => _MatchTheBoxGameState();
}

class _MatchTheBoxGameState extends State<MatchTheBoxGame> {
  List<_ChoiceDetail> choiceDetails;
  List<_ChoiceDetail> answerDetails;
  List<List<String>> addToBox = [[], [], [], []];
  @override
  void initState() {
    super.initState();
    int i = 0;
    int j = 0;
    choiceDetails = widget.choices
        .map((c) => _ChoiceDetail(choice: c, index: i++))
        .toList(growable: false)
          ..shuffle();
    answerDetails = widget.answers
        .map((a) => _ChoiceDetail(choice: a, appear: false, index: j++))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    int k = 0;
    return Column(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: BentoBox(
              rows: 1,
              cols: answerDetails.length,
              children: answerDetails
                  .map((a) => DragTarget<String>(
                        key: Key(a.choice),
                        builder: (context, candidateData, rejectedData) =>
                            LayoutBuilder(builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Container(
                                  height: constraints.maxHeight,
                                  width: constraints.maxWidth,
                                  decoration: new BoxDecoration(
                                    color: Colors.blue,
                                    border: new Border.all(
                                        color: Colors.black, width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: a.appear
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: addToBox[a.index]
                                              .map((f) => Container(
                                                  padding: EdgeInsets.all(3.0),
                                                  height:
                                                      constraints.maxHeight *
                                                          .3,
                                                  width:
                                                      constraints.maxWidth * .5,
                                                  child: CuteButton(
                                                    child: Center(
                                                        child: Text(a.choice)),
                                                  )))
                                              .toList(growable: false))
                                      : Container());
                            }),
                        onWillAccept: (data) {
                          return data[1] == a.choice;
                        },
                        onAccept: (data) => setState(() {
                              int index = int.parse(data[0]);
                              print("${data[0]}......${choiceDetails[index]}");
                              addToBox[a.index].add(a.choice);
                              a.appear = true;
                              choiceDetails[index].appear = false;
                            }),
                      ) as Widget)
                  .toList()),
        ),
        Flexible(
            flex: 1,
            child: BentoBox(
              rows: 1,
              cols: widget.answers.length,
              children: widget.answers
                  .map((t) => Text(
                        t,
                        style: TextStyle(fontSize: 46.0),
                        key: Key(t),
                      ))
                  .toList(growable: false),
            )),
        Flexible(
          flex: 3,
          child: BentoBox(
            calculateLayout: BentoBox.calculateRandomizedLayout,
            dragConfig: DragConfig.draggableBounceBack,
            rows: 2,
            cols: 5,
            children: choiceDetails
                .map((c) => c.appear
                    ? LayoutBuilder(
                        key: Key("${((k++).toString() + c.choice)}"),
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Container(
                              height: constraints.maxHeight * .6,
                              width: constraints.maxWidth * .8,
                              child: CuteButton(
                                child: Center(child: Text(c.choice)),
                              ));
                        })
                    : Container(
                        key: Key("${(k++).toString()}"),
                      ))
                .toList(growable: false),
          ),
        )
      ],
    );
  }
}
