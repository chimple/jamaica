import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MoveCoinAnimation extends StatefulWidget {
  Function(bool) callback;
  int index;
  Offset offset;

  MoveCoinAnimation({Key key, this.callback, this.index, this.offset})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new MoveCoinState();
  }
}

class MoveCoinState extends State<MoveCoinAnimation>
    with TickerProviderStateMixin {
  GlobalKey _globalKey2 = new GlobalKey();
  Animation<double> _size;
  AnimationController _controller;
  Offset begin = Offset(0.0, 0.0);
  Offset end = Offset(100, 200.0);
  var extraSize = 0.0;
  double animationDuration = 0.0;
  double start = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((s) {
      _afterLayout();
    });
    final int totalDuration = 2000;
    _controller = AnimationController(
        vsync: this, duration: new Duration(milliseconds: totalDuration));
    animationDuration = totalDuration / (100 * (totalDuration / widget.index));
     start = (animationDuration * widget.index).toDouble();

    _size = Tween<double>(
      begin: 0,
      end: 50,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    // to increase and decrease coins size from begin to end
    _size.addListener(() {
      if (_controller.value < 0.3) {
        extraSize = extraSize;
      } else if (_controller.value > 0.3 && _controller.value < 0.35) {
        extraSize = extraSize + 3;
      } else if (_controller.value > 0.35 && _controller.value < 0.6) {
        extraSize = extraSize;
      } else if (_controller.value > 0.6 && _controller.value < .7) {
        extraSize = extraSize - 1;
      } else {
        extraSize = extraSize - 2.5;
      }
    });
    _controller.forward();
    _controller.addStatusListener((status) {
      if (_controller.isCompleted) {
        setState(() {
          widget.callback(true);
        });
      }
    });
  }

  void _afterLayout() {
    final RenderBox renderBoxRed =
        _globalKey2.currentContext.findRenderObject();
    Offset offset = -renderBoxRed.globalToLocal(Offset.zero);
    begin = offset;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Stack(
            children: <Widget>[
              _AnimatedCoin(
                scale: Tween<Offset>(
                        begin: begin / 100, end: widget.offset / 100)
                    .animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Interval(
                      start,
                      1.0,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                ),
                child: Container(
                  key: _globalKey2,
                  height: media.height * 0.15 + extraSize,
                  width: media.width * 0.15 + extraSize,
                  child: FlareActor(
                    "assets/coin.flr",
                    // animation: "rotate",
                  ),
                ),
              ),
            ],
          );
        });
  }
}
// using to handle coins animation by passing proper offset
class _AnimatedCoin extends AnimatedWidget {
  final Widget child;
  _AnimatedCoin({
    Key key,
    this.child,
    Animation<Offset> scale,
  }) : super(key: key, listenable: scale);
  Animation<Offset> get listenable => super.listenable;
  double get translateX {
    double val = listenable.value.dx * 100;
    return val;
  }

  double get translateY {
    double val = listenable.value.dy * 100;
    return val;
  }

  double get translateZ {
    double val = listenable.value.dx * 100;
    if (val <= 1.0)
      return 1.0;
    else
      return val;
  }

  @override
  Widget build(BuildContext context) {
    return _SingleChild(
      child: child,
      offset: Offset(
        translateZ,
        translateY,
      ),
    );
  }
}

class _SingleChild extends SingleChildRenderObjectWidget {
  final Widget child;
  final Offset offset;
  _SingleChild({this.child, this.offset}) : super(child: child);
  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderObject(offset: offset);
  }

  @override
  void updateRenderObject(BuildContext context, _RenderObject renderObject) {
    super.updateRenderObject(context, renderObject..offsetUpdate = offset);
  }
}

class _RenderObject extends RenderProxyBox {
  final Offset offset;
  _RenderObject({RenderBox child, this.offset})
      : assert(offset != null),
        _offset = offset,
        super(child);
  Offset _offset;

  set offsetUpdate(Offset of) {
    _offset = of;
    markNeedsPaint();
  }

  @override
  void paint(context, offset) {
    if (child != null) {
      offset = _offset;
      context.paintChild(child, offset);
    }
  }
}
