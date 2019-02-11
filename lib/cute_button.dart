import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

typedef Reaction OnPressed();

enum Reaction { success, failure }

enum _Slot {
  top,
  bottom,
  animation,
  dummy,
}

class CuteButton extends StatefulWidget {
  final bool pressed;
  final Widget child;
  final OnPressed onPressed;
  final Reaction reaction;

  const CuteButton({
    Key key,
    this.child,
    this.pressed = false,
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
  _ButtonStatus buttonStatus;
  Reaction reaction;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void didUpdateWidget(CuteButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initData();
  }

  void _initData() {
    if (buttonStatus == null ||
        buttonStatus == _ButtonStatus.up ||
        buttonStatus == _ButtonStatus.down) {
      buttonStatus = widget.pressed ? _ButtonStatus.down : _ButtonStatus.up;
    } else if (widget.pressed) {
      buttonStatus = _ButtonStatus.upToDown;
    } else {
      buttonStatus = _ButtonStatus.downToUp;
    }
    if (reaction == null && widget.reaction != null) reaction = widget.reaction;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('onTap');
      },
      onTapDown: (t) {
        print('onTapDown');
        Future.delayed(const Duration(milliseconds: 250), () {
          if (buttonStatus == _ButtonStatus.downToUp) {
            setState(() {
              buttonStatus = _ButtonStatus.up;
            });
          } else {
            buttonStatus = _ButtonStatus.down;
          }
        });
        setState(() {
          buttonStatus = _ButtonStatus.upToDown;
        });
      },
      onTapUp: (t) {
        print('onTapUp');
        if (widget.onPressed != null) {
          setState(() => reaction = widget.onPressed());
        }
        if (buttonStatus == _ButtonStatus.upToDown) {
          buttonStatus = _ButtonStatus.downToUp;
        } else {
          setState(() {
            buttonStatus = _ButtonStatus.up;
          });
        }
      },
      onTapCancel: () => setState(() => buttonStatus = _ButtonStatus.up),
      child: CustomMultiChildLayout(
        children: <Widget>[
          LayoutId(
            id: _Slot.bottom,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
            ),
          ),
          LayoutId(
            id: _Slot.top,
            child: Container(
              child: widget.child,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
            ),
          ),
          LayoutId(
            id: _Slot.animation,
            child: reaction != null && buttonStatus == _ButtonStatus.up
                ? FlareActor(
                    "assets/button.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation:
                        reaction == Reaction.success ? 'correct' : 'wrong',
                    callback: (s) {
                      print(s);
                      setState(() => reaction = null);
                    },
                  )
                : Container(),
          )
        ],
        delegate: OneOverOther(buttonStatus == _ButtonStatus.up ? false : true),
      ),
    );
  }
}

class OneOverOther extends MultiChildLayoutDelegate {
  final bool closed;

  OneOverOther(this.closed);

  @override
  void performLayout(Size size) {
    final slotSize = Size(size.width, size.height * 0.9);
    final bottomOffset = Offset(0.0, 0.1 * size.height);
    if (hasChild(_Slot.bottom)) {
      layoutChild(_Slot.bottom, BoxConstraints.tight(slotSize));
      positionChild(_Slot.bottom, bottomOffset);
    }
    if (hasChild(_Slot.top)) {
      layoutChild(_Slot.top, BoxConstraints.tight(slotSize));
      if (closed) {
        positionChild(_Slot.top, bottomOffset);
      } else {
        positionChild(_Slot.top, Offset.zero);
      }
    }
    if (hasChild(_Slot.animation)) {
      layoutChild(_Slot.animation,
          BoxConstraints.tight(Size(size.width, size.height * 0.1)));
      positionChild(_Slot.animation, Offset(0.0, 0.9 * size.height));
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) {
    if (oldDelegate is OneOverOther && oldDelegate.closed != closed) {
      return true;
    }
    return false;
  }
}
