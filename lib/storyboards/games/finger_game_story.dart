import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/finger_game.dart';
import 'package:storyboard/storyboard.dart';

class FingerGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: FingerGame(answer: 3, choices: [2, 3]),
          ),
        ),
        Scaffold(
          body: SafeArea(
            child: FingerGame(answer: 7, choices: [6, 7, 8]),
          ),
        )
      ];
}
