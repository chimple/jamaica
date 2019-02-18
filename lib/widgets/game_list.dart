import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/models/game_config.dart';
import 'package:jamaica/models/game_status.dart';
import 'package:jamaica/screens/game_level.dart';

class GameList extends StatelessWidget {
  final Map<String, List<GameConfig>> games;
  final BuiltMap<String, GameStatus> gameStatuses;

  const GameList({Key key, this.games, this.gameStatuses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    games.forEach((k, v) {
      widgets.add(SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            k,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ));
      widgets.add(SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final gameConfig = v[index];
            List gamelevel = [];
            for(int i=1;i<=gameConfig.levels;i++){
               gamelevel.add(i);
            }
            return Column(
              children: <Widget>[
                Image.asset(gameConfig.image),
                RaisedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return GameLevel(
                              gameName: gameConfig.name,
                              levelList:gamelevel
                            );
                          });
                    },
                    child: Text(
                      gameConfig.name,
                      style: TextStyle(color: Colors.amber),
                    )),
              ],
            );
          },
          childCount: v.length,
        ),
      ));
      widgets.add(SliverToBoxAdapter(
        child: Divider(),
      ));
    });
    return CustomScrollView(primary: true, slivers: widgets);
  }
}
