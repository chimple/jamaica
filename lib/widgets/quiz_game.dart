import 'package:data/models/quiz_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/state/quiz_game_utils.dart';
import 'package:jamaica/state/state_container.dart';
import 'package:jamaica/widgets/game.dart';

class QuizGame extends StatelessWidget {
  final QuizSession quizSession;

  const QuizGame({Key key, this.quizSession}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime startTime;
    startTime = new DateTime.now();
    int i = 0;
    final quizSession = StateContainer.of(context).quizSession;
    final quizUpdate = StateContainer.of(context).quizUpdate;
    if (quizUpdate == null && quizSession != null) {
      return new Center(
          child: new SizedBox(
        width: 20.0,
        height: 20.0,
        child: new CircularProgressIndicator(),
      ));
    }
    return Game(
      quizSession: quizSession,
      updateScore: (int score) {
        DateTime endTime = new DateTime.now();
        sendQuizPerformance(
            gameData: quizSession.gameData[i++],
            score: score,
            startTime: startTime,
            endTime: endTime,
            context: context);
        startTime = endTime;
      },
    );
  }
}
