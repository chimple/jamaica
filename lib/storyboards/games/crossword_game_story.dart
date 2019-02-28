import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/crossword_game.dart';
import 'package:storyboard/storyboard.dart';
import 'package:tuple/tuple.dart';

class CrosswordGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: CrosswordGame(
              data: [
                ['E', null, null, null, null],
                ['A', null, null, null, null],
                ['T', 'I', 'G', 'E', 'R'],
                [null, null, null, null, 'A'],
                [null, null, null, null, 'T']
              ],
              images: [
                Tuple3('assets/accessories/apple.png', 0, 0),
                Tuple3('assets/accessories/camera.png', 2, 0),
                Tuple3('assets/accessories/fruit.png', 2, 4),
              ],
            ),
          ),
        )
      ];
}
