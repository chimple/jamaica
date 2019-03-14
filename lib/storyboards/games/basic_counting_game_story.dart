import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/basic_counting_game.dart';
import 'package:storyboard/storyboard.dart';

class BasicCountingGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: BasicCountingGame(
                answer: 5, choices: [1, 2, 3, 4, 5, 6, 7, 8, 9]),
          ),
        )
      ];
}
