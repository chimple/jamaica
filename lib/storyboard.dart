import 'package:flutter/material.dart';
import 'package:jamaica/screens/story_screen.dart';
import 'package:jamaica/storyboards/collected_item_story.dart';
import 'package:jamaica/storyboards/games/bingo_game_story.dart';
import 'package:jamaica/storyboards/games/counting_game_story.dart';
import 'package:jamaica/storyboards/games/crossword_game_story.dart';
import 'package:jamaica/storyboards/games/dice_game_story.dart';
import 'package:jamaica/storyboards/games/fill_in_the_blanks_story.dart';
import 'package:jamaica/storyboards/games/find_word_game_story.dart';
import 'package:jamaica/storyboards/games/finger_game_story.dart';
import 'package:jamaica/storyboards/games/game_list_story.dart';
import 'package:jamaica/storyboards/games/jumbled_words_game_story.dart';
import 'package:jamaica/storyboards/games/box_matching_game_story.dart';
import 'package:jamaica/storyboards/games/match_the_shape_game_story.dart';
import 'package:jamaica/storyboards/games/match_with_image_game_story.dart';
import 'package:jamaica/storyboards/games/math_op_game_story.dart';
import 'package:jamaica/storyboards/games/memory_game_story.dart';
import 'package:jamaica/storyboards/games/order_by_size_game_story.dart';
import 'package:jamaica/storyboards/games/order_it_game_story.dart';
import 'package:jamaica/storyboards/games/recognize_number_game_story.dart';
import 'package:jamaica/storyboards/games/reflex_game_story.dart';
import 'package:jamaica/storyboards/games/rhyme_words_game_story.dart';
import 'package:jamaica/storyboards/games/sequence_alphabet_game_story.dart';
import 'package:jamaica/storyboards/games/sequence_the_number_game_story.dart';

import 'package:jamaica/storyboards/games/basic_counting_game_story.dart';
import 'package:jamaica/storyboards/games/spin_wheel_game_story.dart';
import 'package:jamaica/storyboards/games/tap_wrong_game_story.dart';
import 'package:jamaica/storyboards/games/true_false_game_story.dart';
import 'package:jamaica/storyboards/user_progress_screen_story.dart';
import 'package:jamaica/storyboards/widgets/audio_widget_story.dart';
import 'package:jamaica/storyboards/widgets/bento_box_story.dart';
import 'package:jamaica/storyboards/widgets/chat_bot_screen_story.dart';
import 'package:jamaica/storyboards/widgets/chat_bot_story.dart';
import 'package:jamaica/storyboards/widgets/cute_button_story.dart';
import 'package:jamaica/storyboards/widgets/dot_number_story.dart';
import 'package:jamaica/storyboards/games/game_level_story.dart';
import 'package:jamaica/storyboards/games/score_screen_story.dart';
import 'package:jamaica/storyboards/theme_map_story.dart';
import 'package:jamaica/storyboards/widgets/game_story.dart';
import 'package:jamaica/storyboards/widgets/quiz_timer_story.dart';
import 'package:jamaica/storyboards/widgets/score_story.dart';
import 'package:jamaica/storyboards/widgets/select_student_screen_story.dart';
import 'package:jamaica/storyboards/widgets/select_teacher_screen_story.dart';
import 'package:jamaica/storyboards/widgets/slide_up_route_story.dart';
import 'package:jamaica/storyboards/widgets/story_board.dart';
import 'package:jamaica/storyboards/widgets/store_screen_story.dart';
import 'package:storyboard/storyboard.dart';

void main() {
  runApp(StoryboardApp([
    AudioWidgetStory(),
    BasicCountingGameStory(),
    BentoBoxStory(),
    BingoGameStory(),
    BoxMatchingGameStory(),
    ChatBotStory(),
    ChatBotScreenStory(),
    CollectedItemStory(),
    CountingGameStory(),
    CrosswordGameStory(),
    CuteButtonStory(),
    DiceGameStory(),
    DotNumberStory(),
    FillInTheBlanksGameStory(),
    FindWordGameStory(),
    FingerGameStory(),
    GameStory(),
    GameLevelStory(),
    GameListStory(),
    JumbledWordsGameStory(),
    MatchTheShapeGameStory(),
    MatchWithImageGameStory(),
    MathOpGameStory(),
    MemoryGameStory(),
    OrderBySizeGameStory(),
    OrderItGameStory(),
    QuizTimerStory(),
    RecognizeNumberGameStory(),
    ReflexGameStory(),
    RhymeWordsGameStory(),
    SelectTeacherScreenStory(),
    SelectStudentScreenStory(),
    SequenceAlphabetGameStory(),
    SequenceTheNumberGameStory(),
    SlideUpRouteStory(),
    SpinWheelGameStory(),
    StoreScreenStory(),
    ScoreStory(),
    StoryBoard(),
    TapWrongGameStory(),
    ThemeMapStory(),
    TrueFalseGameStory(),
    UserProgressScreenStory(),
  ]));
}
