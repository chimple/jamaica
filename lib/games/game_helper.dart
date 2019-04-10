import 'package:flutter/material.dart';

class HelperData {
  static var gameId;
  static var choices;
  static var answers;
  static var special;
  static var special2;
  static Function(int) callback;

  startHelp() {
    print('came $choices');
    print('came $answers');
    for (int i = 0; i < choices.length; i++) {
      if (_gameMethods(choices[i], answers)) {
        callback(i);
        break;
      }
    }
  }

  _gameMethods(choice, answer) {
    switch (gameId) {
      case 'CountingGame':
        return choice == answer[0].choices;
        break;
      case 'FindWordGame':
        return choice.letter == answer[special];
        break;
    }
  }
}
