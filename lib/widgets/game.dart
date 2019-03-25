import 'package:data/models/contest_session.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/state/game_utils.dart';
import 'package:jamaica/state/performance_utils.dart';
import 'package:jamaica/state/state_container.dart';
import 'package:jamaica/widgets/score.dart';
import 'package:jamaica/widgets/slide_up_route.dart';
import 'package:jamaica/widgets/stars.dart';

class Game extends StatefulWidget {
  final ContestSession contestSession;
  final UpdateCoins updateCoins;

  const Game({Key key, this.contestSession, this.updateCoins})
      : super(key: key);
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _currentGame = 0;
  int _score = 0;
  int _stars = 0;
  DateTime startTime;
  Navigator _navigator;

  @override
  void initState() {
    super.initState();
    _navigator = Navigator(
      onGenerateRoute: (settings) => SlideUpRoute(
            widgetBuilder: (context) => _buildGame(context, 0),
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startTime = new DateTime.now();
    final contestSession = StateContainer.of(context).contestSession;
    final contestStart = StateContainer.of(context).contestStart;
    if (contestStart == null && contestSession != null) {
      return new Center(
          child: new SizedBox(
        width: 20.0,
        height: 20.0,
        child: new CircularProgressIndicator(),
      ));
    }
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Expanded(
              child: _navigator,
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 128.0,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 128.0,
                        width: 128.0,
                        child: Hero(
                          tag: 'chimp',
                          child: FlareActor("assets/character/chimp.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              animation: "idle"),
                        ),
                      ),
                      Expanded(
                        child: Stars(
                          total: widget.contestSession.gameData.length,
                          show: _stars,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGame(BuildContext context, int index) {
    final contestStart = StateContainer.of(context).contestStart;
    if (index < widget.contestSession.gameData.length) {
      return buildGame(
          gameData: widget.contestSession.gameData[index],
          onGameOver: (score) {
            DateTime endTime = new DateTime.now();
            contestStart != null
                ? performance(
                    gameData: widget.contestSession.gameData[_currentGame],
                    score: score,
                    startTime: startTime,
                    endTime: endTime,
                    context: context)
                : Container();

            setState(() {
              _score += score;
              if (score > 0) _stars++;
//              _currentGame++;
            });
            Navigator.push(
                context,
                SlideUpRoute(
                    widgetBuilder: (context) => _buildGame(context, ++index)));
            startTime = endTime;
          });
    } else {
      return Score(
        score: _score,
        starCount: _score,
        coinsCount: _score,
        updateCoins: widget.updateCoins,
      );
    }
  }
}
