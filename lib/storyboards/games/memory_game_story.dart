import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/memory_game.dart';
import 'package:storyboard/storyboard.dart';

class MemoryGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: MemoryGame(
              first: ['1', '2', '3', '4'],
              second: ['1', '2', '3', '4'],
            ),
          ),
        ),
      ];
}
