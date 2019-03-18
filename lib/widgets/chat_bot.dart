import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

typedef void ChatCallback(String text);

class ChatBot extends StatelessWidget {
  final String text;
  final List<String> choices;
  final ChatCallback chatCallback;

  const ChatBot({Key key, this.text, this.choices, this.chatCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: Hero(
            tag: 'chimp',
            child: FlareActor("assets/character/chimp.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "idle"),
          ),
        ),
        Text(text),
        Expanded(
          child: Align(
            alignment: Alignment(-1, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: choices
                  .map((c) => RaisedButton(
                        child: Text(c),
                        onPressed: () => chatCallback(c),
                      ))
                  .toList(growable: false),
            ),
          ),
        )
      ],
    );
  }
}
