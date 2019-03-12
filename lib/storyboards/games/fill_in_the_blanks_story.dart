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
                    data: Tuple2(' Mount Everest is the highest 1_ in the 2_ .',
                        ['mountain', 'earth', 'chair', 'ball'])))),
        Scaffold(
            body: SafeArea(
                child: FillInTheBlanksGame(
                    data: Tuple2(
                        ' The fact is Mount Everest is the highest 1_ in the earth followed by K2,located in the Himalayas.',
                        ['mountain', 'earth', 'chair', 'ball'])))),
        Scaffold(
            body: SafeArea(
                child: FillInTheBlanksGame(
                    data: Tuple2('Lion is the king of the 1_ .',
                        ['jungle', 'earth', 'chair', 'ball']))))
      ];
}