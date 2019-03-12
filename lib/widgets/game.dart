import 'package:data/models/contest_session.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  final ContestSession contestSession;

  const Game({Key key, this.contestSession}) : super(key: key);
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
