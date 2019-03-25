import 'package:data/models/contest_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/state/contest_game_utils.dart';
import 'package:jamaica/state/state_container.dart';
import 'package:jamaica/widgets/game.dart';

class ContestGame extends StatelessWidget {
  final ContestSession contestSession;

  const ContestGame({Key key, this.contestSession}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime startTime;
    startTime = new DateTime.now();
    int i = 0;
    final contestSession = StateContainer.of(context).contestSession;
    final contestStart = StateContainer.of(context).contestStart;
    if (contestStart == null && contestSession != null) {
      return new Center(
          child: new SizedBox(
        width: 20.0,
        height: 20.0,
        child: new CircularProgressIndicator(),
      ));
    }
    return Game(
      contestSession: contestSession,
      quizScore: (score) {
        DateTime endTime = new DateTime.now();
        contestPerformance(
            gameData: contestSession.gameData[i++],
            score: score,
            startTime: startTime,
            endTime: endTime,
            context: context);
        startTime = endTime;
      },
    );
  }
}
