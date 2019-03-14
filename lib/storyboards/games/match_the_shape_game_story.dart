import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/match_the_shape_game.dart';
import 'package:storyboard/storyboard.dart';

class MatchTheShapeGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: MatchTheShapeGame(
              first: ['1', '2', '3', '4'],
              second: ['1', '2', '3', '4'],
            ),
          ),
        )
      ];
}
