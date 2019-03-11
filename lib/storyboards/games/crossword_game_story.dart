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
        ),
        Scaffold(
          body: SafeArea(
            child: CrosswordGame(
              data: [
                ['T', 'E', 'X', 'T'],
                [null, null, 'M', null],
                ['J', 'O', 'I', 'N'],
                [null, null, 'C', null],
              ],
              images: [
                Tuple3('assets/accessories/join.png', 2, 0),
                Tuple3('assets/accessories/text.png', 0, 0),
                Tuple3('assets/accessories/mic.png', 1, 2),
              ],
            ),
          ),
        ),
        Scaffold(
          body: SafeArea(
            child: CrosswordGame(
              data: [
                [null, 'A', null, 'T', null, 'G'],
                ['M', 'P', null, 'E', null, 'R'],
                ['I', 'P', null, 'X', null, 'A'],
                ['C', 'L', 'O', 'T', 'H', 'I'],
                [null, 'E', 'J', 'O', 'I', 'N'],
                [null, null, null, null, null, 'S'],
              ],
              images: [
                Tuple3('assets/accessories/apple.png', 0, 1),
                Tuple3('assets/accessories/text.png', 0, 3),
                Tuple3('assets/accessories/grains.png', 0, 5),
                Tuple3('assets/accessories/clothes.png', 3, 0),
                Tuple3('assets/accessories/mic.png', 1, 0),
                Tuple3('assets/accessories/join.png', 4, 2),
              ],
            ),
          ),
        )
      ];
}
