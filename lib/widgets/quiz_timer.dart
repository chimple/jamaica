import 'package:flutter/material.dart';

class QuizTimer extends StatefulWidget {
  final int time;
  QuizTimer({Key key, this.time = 10}) : super(key: key);
  @override
  QuizTimerState createState() => QuizTimerState();
}

class QuizTimerState extends State<QuizTimer> with TickerProviderStateMixin {
  AnimationController animationController;
 
  String get timerString {
    Duration duration =
        animationController.duration * animationController.value;
    return '${duration.inMinutes}${(duration.inSeconds % 60)}';
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.time));
          animationController.reverse(
                        from: animationController.value == 0.0
                            ? 1.0
                            : animationController.value);

  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 600.0,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
              return CustomPaint(
                painter: TimerPainter(
                    animation: animationController,
                    backgroundColor: Colors.white,
                    color: Theme.of(context).accentColor),
              );
            },
          ),
        ),
        // AnimatedBuilder(
        //     animation: animationController,
        //     builder: (_, Widget child) {
        //       return Text(
        //         timerString,
        //         style: Theme.of(context).textTheme.display4,
        //       );
        //     }),
        // Container(
        //   margin: EdgeInsets.all(8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       FloatingActionButton(
        //         child: AnimatedBuilder(
        //             animation: animationController,
        //             builder: (_, Widget child) {
        //               return Icon(animationController.isAnimating
        //                   ? Icons.pause
        //                   : Icons.play_arrow);
        //             }),
        //         onPressed: () {
        //           int timeTaken = int.parse(timerString);
        //           if (animationController.isAnimating) {
        //             animationController.stop();
        //           } else {
        //             animationController.reverse(
        //                 from: animationController.value == 0.0
        //                     ? 1.0
        //                     : animationController.value);
        //           }
        //           print(widget.time - timeTaken);
        //         },
        //       )
        //     ],
        //   ),
        // )
      ],
    );
  }
}

class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor;
  final Color color;

  TimerPainter({this.animation, this.backgroundColor, this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(0.0, size.height / 2);
    final end = Offset(size.width, size.height / 2);
    Paint paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(start, end, paint);
    paint.color = Colors.blue;
    double progress = (1.0 - animation.value) * end.dx;
    canvas.drawLine(start, Offset(end.dx - progress, end.dy), paint);
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
