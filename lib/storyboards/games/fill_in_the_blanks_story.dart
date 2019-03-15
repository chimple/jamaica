import 'package:built_collection/built_collection.dart';
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
              question: ' Mount Everest is the highest 1_ in the 2_ .',
              answers:
                  BuiltList<String>(['mountain', 'earth', 'chair', 'ball']),
            ),
          ),
        ),
        Scaffold(
            body: SafeArea(
                child: FillInTheBlanksGame(
                    question:
                        ' The fact is Mount Everest is the highest 1_ in the earth followed by K2,located in the Himalayas.',
                    answers: BuiltList<String>(
                        ['mountain', 'earth', 'chair', 'ball'])))),
        Scaffold(
            body: SafeArea(
                child: FillInTheBlanksGame(
                    question: 'Lion is the king of the 1_ .',
                    answers: BuiltList<String>(
                        ['jungle', 'earth', 'chair', 'ball']))))
      ];
}
