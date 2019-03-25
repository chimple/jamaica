import 'dart:convert';
import 'package:built_value/standard_json_plugin.dart';
import 'package:data/models/contest_join.dart';
import 'package:data/models/serializers.dart';
import 'package:flutter/material.dart';
import 'package:jamaica/state/state_container.dart';
import 'package:jamaica/widgets/contest_game.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final contestSession = StateContainer.of(context).contestSession;

    return Scaffold(
        key: _scaffoldKey,
        body: contestSession == null
            ? SafeArea(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.account_circle),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/profile'),
                        ),
                        IconButton(
                          icon: Icon(Icons.map),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/map'),
                        ),
                        IconButton(
                          icon: Icon(Icons.games),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/games'),
                        ),
                        IconButton(
                          icon: Icon(Icons.store),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/store'),
                        ),
                        IconButton(
                          icon: Icon(Icons.book),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/story'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : AlertDialog(
                title: new Text("Quiz  to Start student"),
                content: RaisedButton(
                    onPressed: () {
                      final standardSerializers = (serializers.toBuilder()
                            ..addPlugin(StandardJsonPlugin()))
                          .build();

                      final contestSession =
                          StateContainer.of(context).contestSession;
                      final studentId = StateContainer.of(context).studentIdVal;

                      ContestJoin contestJoin = ContestJoin((d) => d
                        ..sessionId = contestSession.sessionId
                        ..studentId = studentId);

                      final jsoncontestJoin =
                          standardSerializers.serialize(contestJoin);
                      final jsoncontestJoinString = jsonEncode(jsoncontestJoin);
                      print(jsoncontestJoinString);
                      print(".......object is.....$contestJoin");
                      final endPointId =
                          StateContainer.of(context).contestSessionEndPointId;
                      StateContainer.of(context)
                          .sendMessageTo(endPointId, jsoncontestJoinString);

                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (ctxt) => new ContestGame(
                                  contestSession: contestSession,
                                )),
                      );
                    },
                    child: new Text("Yes, Ready To Play")),
              ));
  }
}
