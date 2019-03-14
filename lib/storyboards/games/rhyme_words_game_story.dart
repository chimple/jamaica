import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/finger_game.dart';
import 'package:jamaica/games/rhyme_words_game.dart';
import 'package:storyboard/storyboard.dart';

class RhymeWordsGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: RhymeWordsGame(
              questions: [
                'Pin',
                'Pet',
                'Me',
                'Bee',
              ],
              answers: [
                'Win',
                'Wet',
                'We',
                'See',
              ],
            ),
          ),
        ),
      ];
}
