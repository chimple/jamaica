import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CollectionProgressIndicator extends StatelessWidget {
  final double width;
  final double progress;
  final Color color;

  const CollectionProgressIndicator(
      {Key key, this.width, this.progress, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: (context, constraints) {
      return LinearPercentIndicator(
        width: width,
        lineHeight: 10,
        percent: min(progress ?? 0.0, 1.0),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Colors.red,
        backgroundColor: Colors.white,
      );
    });
  }
}
