import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

typedef Reaction OnPressed();

enum Reaction { enter, success, failure }

final Map<Reaction, String> _reactionMap = {
  Reaction.enter: 'enter',
  Reaction.success: 'happy',
  Reaction.failure: 'sad',
};

class CuteButton extends StatefulWidget {
  final Widget child;
  final OnPressed onPressed;
  final Reaction reaction;

  const CuteButton({
    Key key,
    this.child,
    this.onPressed,
    this.reaction,
  }) : super(key: key);

  @override
  CuteButtonState createState() {
    return new CuteButtonState();
  }
}

enum _ButtonStatus { up, down, upToDown, downToUp }

class CuteButtonState extends State<CuteButton> {
  _ButtonStatus buttonStatus = _ButtonStatus.down;
  Reaction reaction;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void didUpdateWidget(CuteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('old: ${oldWidget.reaction} new: ${widget.reaction}');
    if (oldWidget.reaction != widget.reaction) _initData();
  }

  void _initData() {
    print('initData');
    if (reaction == null && widget.reaction != null) {
      reaction = widget.reaction;
      if (buttonStatus == _ButtonStatus.down) {
        buttonStatus = _ButtonStatus.downToUp;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('buttonStatus: $buttonStatus');
    if (buttonStatus == _ButtonStatus.downToUp) {
      Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {
          buttonStatus = _ButtonStatus.up;
        });
      });
    } else if (buttonStatus == _ButtonStatus.upToDown) {
      Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {
          buttonStatus = _ButtonStatus.down;
          reaction = null;
        });
      });
    } else if (buttonStatus == _ButtonStatus.up) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          buttonStatus = _ButtonStatus.upToDown;
        });
      });
    }
    return LayoutBuilder(builder: (context, constraints) {
      return RaisedButton(
        onPressed:
            (widget.onPressed == null || buttonStatus != _ButtonStatus.down)
                ? null
                : () {
                    setState(() {
                      buttonStatus = _ButtonStatus.downToUp;
                      reaction = widget.onPressed();
                    });
                  },
        color: Colors.blue,
        disabledColor: Colors.blue,
        textColor: Colors.white,
        disabledTextColor: Colors.white,
        shape: new RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(16.0))),
        child: Stack(
          children: <Widget>[
            buttonStatus != _ButtonStatus.up ? widget.child : Container(),
            AnimatedPositioned(
              top: (buttonStatus == _ButtonStatus.up ||
                      buttonStatus == _ButtonStatus.downToUp)
                  ? 0.0
                  : constraints.maxHeight,
              left: 0.0,
              right: 0.0,
              bottom: (buttonStatus == _ButtonStatus.up ||
                      buttonStatus == _ButtonStatus.downToUp)
                  ? 0.0
                  : -constraints.maxHeight,
              duration: Duration(milliseconds: 250),
              child: FlareActor(
                "assets/character/button.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: buttonStatus == _ButtonStatus.up
                    ? _reactionMap[reaction]
                    : 'dummy',
              ),
            )
          ],
        ),
      );
    });
  }
}
