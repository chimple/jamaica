import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/find_word_game.dart';
import 'package:storyboard/storyboard.dart';

class FindWordGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: FindWordGame(
              image: 'assets/accessories/apple.png',
              answer: ['A', 'P', 'P', 'L', 'E'],
              choices: ['A', 'X', 'Y', 'P', 'E', 'B', 'L', 'W'],
            ),
          ),
        ),
      ];
}
