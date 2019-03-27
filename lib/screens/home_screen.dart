import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:math';

import 'package:built_value/standard_json_plugin.dart';
import 'package:data/data.dart';
import 'package:flutter/services.dart';
import 'package:jamaica/widgets/chat_bot.dart';
import 'package:jamaica/widgets/slide_up_route.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  Navigator _navigator;
  ChatScript _chatScript;
  String _emotion = 'idle';
  Random _random = Random();

  @override
  void initState() {
    super.initState();
    _navigator = Navigator(
      onGenerateRoute: (settings) => SlideUpRoute(
            widgetBuilder: (context) => _buildChatBot(context),
          ),
    );

    _loadChatScript();
  }

  _loadChatScript() async {
    final standardSerializers =
        (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

    final jsonString =
        await rootBundle.loadString('assets/chat/chat_script.json');
    final json = jsonDecode(jsonString);
    setState(() {
      _isLoading = false;
      _chatScript = standardSerializers.deserialize(json);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('ChatBotScreen:build');
    if (_isLoading) {
      return Container(
        child: Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Expanded(
              child: _navigator,
            ),
            Flexible(
              child: Hero(
                tag: 'chimp',
                child: FlareActor(
                  "assets/character/chimp.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: _emotion,
                  callback: (String name) => setState(() => _emotion = 'idle'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.account_circle),
                  onPressed: () => Navigator.of(context).pushNamed('/profile'),
                ),
                IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () => Navigator.of(context).pushNamed('/map'),
                ),
                IconButton(
                  icon: Icon(Icons.games),
                  onPressed: () => Navigator.of(context).pushNamed('/games'),
                ),
                IconButton(
                  icon: Icon(Icons.store),
                  onPressed: () => Navigator.of(context).pushNamed('/store'),
                ),
                IconButton(
                  icon: Icon(Icons.book),
                  onPressed: () => Navigator.of(context).pushNamed('/story'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBot(BuildContext context, {String choice}) {
    print('_buildChatBot');
    final question = getChatQuestion(input: choice);
    return ChatBot(
      text: question.question,
      choices: question.choices
          .map((c) => _chatScript.choices[c].choice)
          .toList(growable: false),
      chatCallback: (String choice) {
        setState(() {
          _emotion = 'happy';
        });
        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.of(context).push(SlideUpRoute(
            widgetBuilder: (context) => _buildChatBot(context, choice: choice),
          ));
        });
      },
    );
  }

  ChatQuestion getChatQuestion({String input}) {
    ChatQuestion question;
    if (input != null) {
      final chosenChoice = _chatScript.choices[input];
      if (chosenChoice != null && chosenChoice.questions != null) {
        final q = chosenChoice
            .questions[_random.nextInt(chosenChoice.questions.length)];
        question = _chatScript.questions[q];
      }
    }
    if (question == null) {
      question = _chatScript.questions.entries
          .elementAt(_random.nextInt(_chatScript.questions.length))
          .value;
    }
    return question;
  }
}
