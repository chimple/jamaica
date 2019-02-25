import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/jumbled_words_game.dart';
import 'package:storyboard/storyboard.dart';

class JumbledWordsGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: JumbledWordsGame(
              answer: 'A',
              choices: ['A', 'B', 'C', 'D'],
            ),
          ),
        ),
      ];
}
