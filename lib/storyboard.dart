import 'package:flutter/material.dart';
import 'package:jamaica/storyboards/collected_item_story.dart';
import 'package:jamaica/storyboards/games/counting_game_story.dart';
import 'package:jamaica/storyboards/games/dice_game_story.dart';
import 'package:jamaica/storyboards/games/find_word_game_story.dart';
import 'package:jamaica/storyboards/games/finger_game_story.dart';
import 'package:jamaica/storyboards/games/game_list_story.dart';
import 'package:jamaica/storyboards/games/match_the_shape_game_story.dart';
import 'package:jamaica/storyboards/games/match_with_image_game_story.dart';
import 'package:jamaica/storyboards/games/math_op_game_story.dart';
import 'package:jamaica/storyboards/games/memory_game_story.dart';
import 'package:jamaica/storyboards/games/order_by_size_game_story.dart';
import 'package:jamaica/storyboards/games/recognize_number_game_story.dart';
import 'package:jamaica/storyboards/games/rhyme_words_game_story.dart';
import 'package:jamaica/storyboards/games/sequence_the_number_game_story.dart';
import 'package:jamaica/storyboards/games/basic_counting_game_story.dart';
import 'package:jamaica/storyboards/widgets/audio_widget_story.dart';
import 'package:jamaica/storyboards/widgets/dot_number_story.dart';
import 'package:jamaica/storyboards/games/game_level_story.dart';
import 'package:jamaica/storyboards/games/score_screen_story.dart';
import 'package:jamaica/storyboards/user_progress_story.dart';
import 'package:jamaica/storyboards/theme_map_story.dart';
import 'package:jamaica/storyboards/widgets/store_screen_story.dart';
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
    FingerGameStory(),
    RecognizeNumberGameStory(),
    OrderBySizeGameStory(),
    FindWordGameStory(),
    MatchWithImageGameStory(),
    RhymeWordsGameStory(),
    GameListStory(),
    StoreScreenStory(),
    CollectedItemStory(),
    DotNumberStory(),
    UserProgressStory(),
    GameLevelStory(),
    ScoreScreenStory(),
    ThemeMapStory(),
    AudioWidgetStory()
  ]));
}
