import 'package:flutter/material.dart';
import 'package:jamaica/games/box_matching_game.dart';
import 'package:storyboard/storyboard.dart';

class MatchTheBoxGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: MatchTheBoxGame(
              choices: ['A', 'B', 'C', 'D', 'A', 'B','C','D','A','B'],
              answers: ['A','B','C','D']
            ),
          ),
        )
      ];
}
