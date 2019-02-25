import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/sequence_alphabet_game.dart';
import 'package:storyboard/storyboard.dart';

class SequenceAlphabetGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: SequenceAlphabetGame(
              answers: ['A', 'P', 'P', 'L', 'E'],
            ),
          ),
        ),
      ];
}
