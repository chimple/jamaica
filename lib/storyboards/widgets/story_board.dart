import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/screens/story_screen.dart';
import 'package:storyboard/storyboard.dart';

class StoryBoard extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: StoryScreen(),
          ),
        )
      ];
}
