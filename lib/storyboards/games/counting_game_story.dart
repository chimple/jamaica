import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/counting_game.dart';
import 'package:storyboard/storyboard.dart';

class CountingGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: CountingGame(
                answer: 5, choices: [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]),
          ),
        ),
        Scaffold(
          body: SafeArea(
            child: CountingGame(answer: 2, choices: [1, 2]),
          ),
        )
      ];
}