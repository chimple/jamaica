import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:jamaica/models/game_config.dart';
import 'package:jamaica/state/state_container.dart';
import 'package:jamaica/widgets/game_list.dart';

final Map<String, List<GameConfig>> _games = {
  'Math Games': [
    GameConfig((b) => b
      ..name = 'Match the shape'
      ..image = 'match_the_shape.png'
      ..levels = 10),
    GameConfig((b) => b
      ..name = 'Domino Math'
      ..image = 'domino_math.png'
      ..levels = 10),
    GameConfig((b) => b
      ..name = 'Memory match'
      ..image = 'memory_match.png'
      ..levels = 10),
  ],
  'Reading Games': [
    GameConfig((b) => b
      ..name = 'Match the following'
      ..image = 'match_the_following.png'
      ..levels = 10),
    GameConfig((b) => b
      ..name = 'Alphabet'
      ..image = 'alphabet.png'
      ..levels = 10),
  ],
};

class GamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Games'),
        ),
        body: GameList(
          games: _games,
          gameStatuses: container.state.userProfile.gameStatuses,
        ));
  }
}
