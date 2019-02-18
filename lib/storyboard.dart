import 'package:flutter/material.dart';
import 'package:jamaica/storyboards/collected_item_story.dart';
import 'package:jamaica/storyboards/games/game_list_story.dart';
import 'package:jamaica/storyboards/games/sequence_the_number_game_story.dart';
import 'package:storyboard/storyboard.dart';

void main() {
  runApp(StoryboardApp([
    SequenceTheNumberGameStory(),
    GameListStory(),
    CollectedItemStory(),
  ]));
}
