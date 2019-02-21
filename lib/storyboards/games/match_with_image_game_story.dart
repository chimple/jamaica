import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/games/match_with_image_game.dart';
import 'package:storyboard/storyboard.dart';

class MatchWithImageGameStory extends FullScreenStory {
  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: MatchWithImageGame(
              images: [
                'assets/accessories/apple.png',
                'assets/accessories/camera.png',
                'assets/accessories/fruit.png'
              ],
              choices: [
                'Camera',
                'Fruit',
                'Apple',
              ],
              answers: [
                'Apple',
                'Camera',
                'Fruit',
              ],
            ),
          ),
        ),
      ];
}
