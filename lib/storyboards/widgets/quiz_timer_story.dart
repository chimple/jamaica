import 'package:flutter/material.dart';
import 'package:jamaica/widgets/quiz_timer.dart';
import 'package:storyboard/storyboard.dart';

class QuizTimerStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          backgroundColor: Colors.purple,
          body: SafeArea(
            child: QuizTimer(
            ),
          ),
        )
      ];
}