import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/recognize_number_game.dart';
import 'package:storyboard/storyboard.dart';

class RecognizeNumberGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: Container(
              color: Colors.white,
              child: RecognizeNumberGame(
                answer: 1,
                choices: [2, 1, 4, 3],
              ),
            ),
          ),
        )
      ];
}
