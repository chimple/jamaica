import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamaica/models/game_config.dart';
import 'package:jamaica/models/game_status.dart';
import 'package:jamaica/screens/game_level.dart';
import 'package:storyboard/storyboard.dart';

class GameLevelStory extends FullScreenStory {
final Map<String, List<GameConfig>> games;
  final BuiltMap<String, GameStatus> gameStatuses;

  GameLevelStory({Key key,this.games, this.gameStatuses});

  

  @override
  List<Widget> get storyContent => [
        Scaffold(
          body: SafeArea(
            child: GameLevel(
                gameName:'Match the Following',
                levelList: ["1"],
            ),
          ),
        ),
      ];
}