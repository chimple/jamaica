import 'package:data/data.dart';
import 'package:data/models/contest_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/widgets/game.dart';
import 'package:storyboard/storyboard.dart';

class GameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Game(
          updateCoins: (coins) => print(coins),
          contestSession: ContestSession((b) => b
            ..gameId = 'CountingGame'
            ..level = 1
            ..sessionId = '2'
            ..gameData.addAll([
              NumMultiData((g) => g
                ..gameId = 'CountingGame'
                ..answers.addAll([5])
                ..choices.addAll([1, 2, 3, 4, 5, 6, 7, 8, 9])),
              NumMultiData((g) => g
                ..gameId = 'CountingGame'
                ..answers.addAll([3])
                ..choices.addAll([1, 2, 3, 4, 5, 6, 7, 8, 9])),
              NumMultiData((g) => g
                ..gameId = 'CountingGame'
                ..answers.addAll([8])
                ..choices.addAll([1, 2, 3, 4, 5, 6, 7, 8, 9])),
            ])),
        ),
      ];
}
