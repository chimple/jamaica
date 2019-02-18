import 'package:flutter/material.dart';
import 'package:jamaica/storyboards/games/counting_game_story.dart';
import 'package:jamaica/storyboards/games/dice_game_story.dart';
import 'package:jamaica/storyboards/games/game_list_story.dart';
import 'package:jamaica/storyboards/games/match_the_shape_game_story.dart';
import 'package:jamaica/storyboards/games/math_op_game_story.dart';
import 'package:jamaica/storyboards/games/memory_game_story.dart';
import 'package:jamaica/storyboards/games/sequence_the_number_game_story.dart';
import 'package:jamaica/storyboards/games/basic_counting_game_story.dart';
import 'package:jamaica/storyboards/widgets/dot_number_story.dart';
import 'package:storyboard/storyboard.dart';

void main() {
  runApp(StoryboardApp([
    SequenceTheNumberGameStory(),
    MatchTheShapeGameStory(),
    MemoryGameStory(),
    BasicCountingGameStory(),
    DiceGameStory(),
    MathOpGameStory(),
    CountingGameStory(),
    GameListStory(),
    DotNumberStory(),
  ]));
}
