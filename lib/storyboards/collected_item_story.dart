import 'package:flutter/material.dart';
import 'package:jamaica/widgets/collected_item_screen.dart';
import 'package:storyboard/storyboard.dart';

class CollectedItemStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea( 
            child: CollectedItemScreen(),
          ),
        )
      ];
}
