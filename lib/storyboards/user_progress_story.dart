import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/sequence_the_number_game.dart';
import 'package:jamaica/screens/user_progress.dart';
import 'package:storyboard/storyboard.dart';

class UserProgressStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: UserProgress(),
          ),
        )
      ];
}
