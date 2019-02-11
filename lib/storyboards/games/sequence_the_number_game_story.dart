import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/sequence_the_number_game.dart';
import 'package:storyboard/storyboard.dart';

class SequenceTheNumberGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        SequenceTheNumberGame(
          sequence: [1, 2, 3, 4],
          choices: [3, 5, 6],
          blankPosition: 2,
        )
      ];
}
