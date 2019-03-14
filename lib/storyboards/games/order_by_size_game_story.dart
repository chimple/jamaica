import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/order_by_size_game.dart';
import 'package:storyboard/storyboard.dart';

class OrderBySizeGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: OrderBySizeGame(answers: [1, 7], choices: [2, 7, 3, 1]),
          ),
        )
      ];
}
