import 'package:flutter/material.dart';
import 'package:jamaica/games/fill_in_the_blanks_game.dart';
import 'package:storyboard/storyboard.dart';
import 'package:tuple/tuple.dart';

class FillInTheBlanksGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: FillInTheBlanksGame(
              data: [
                Tuple2('Z', 'O'),
                Tuple2('', 'Z'),
                Tuple2('Z', 'F'),
                Tuple2('', 'Z'),
                Tuple2('Z', 'F'),
              ],
            ),
          ),
        ),
        Scaffold(
          body: SafeArea(
            child: FillInTheBlanksGame(
              data: [
                Tuple2('', 'O'),
                Tuple2('', 'O'),
                Tuple2('O', 'P'),
                Tuple2('O', 'S'),
                Tuple2('', 'O'),
              ],
            ),
          ),
        )
      ];
}
