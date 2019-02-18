import 'package:flutter/material.dart';
import 'package:jamaica/storyboards/games/game_level_story.dart';
import 'package:jamaica/storyboards/games/game_list_story.dart';
import 'package:jamaica/storyboards/games/score_screen_story.dart';
import 'package:jamaica/storyboards/games/sequence_the_number_game_story.dart';
import 'package:jamaica/storyboards/user_progress_story.dart';
import 'package:jamaica/storyboards/theme_map_story.dart';
import 'package:storyboard/storyboard.dart';

void main() {
  runApp(StoryboardApp([
    SequenceTheNumberGameStory(),
    GameListStory(),
    UserProgressStory(),
    GameLevelStory(),
    ScoreScreenStory(),
    ThemeMapStory()
  ]));
}
