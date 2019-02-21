import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/dice_game.dart';
import 'package:storyboard/storyboard.dart';

class DiceGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: DiceGame(
              question: 4,
              answerPosition: 1,
              choices: [1, 4, 5, 8],
            ),
          ),
        )
      ];
}
