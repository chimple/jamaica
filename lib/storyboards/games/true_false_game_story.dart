import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/finger_game.dart';
import 'package:jamaica/games/true_false_game.dart';
import 'package:storyboard/storyboard.dart';

class TrueFalseGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: TrueFalseGame(
              questions: [
                'Pin',
              ],
              answers: [
                'Win',
              ],
              choices: ['Right', 'Wrong'],
              right_or_wrong: false,
            ),
          ),
        ),
      ];
}
