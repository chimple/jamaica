import 'dart:convert';
import 'package:built_value/standard_json_plugin.dart';
import 'package:data/data.dart';
import 'package:flutter/widgets.dart';
import 'package:jamaica/state/state_container.dart';

sendQuizPerformance(
    {GameData gameData,
    int score,
    DateTime startTime,
    DateTime endTime,
    BuildContext context}) {
  final contestSession = StateContainer.of(context).quizSession;
  switch (gameData.gameId) {
    case 'BasicCountingGame':
      final gd = gameData as NumMultiData;

      return sendPerformance(contestSession, gd.answers[0].toString(), score,
          startTime, endTime, context);

      break;
    case 'BingoGame':
      final gd = gameData as MultiData;

      return sendPerformance(
          contestSession, gd.answers[0], score, startTime, endTime, context);
      break;
    case 'BoxMatchingGame':
      final gd = gameData as MultiData;

      return sendPerformance(
          contestSession, gd.answers[0], score, startTime, endTime, context);
      break;
    case 'CountingGame':
      final gd = gameData as NumMultiData;

      return sendPerformance(contestSession, gd.answers[0].toString(), score,
          startTime, endTime, context);
      break;
    case 'CrosswordGame':
      final gd = gameData as CrosswordData;

      break;
    case 'DiceGame':
      final gd = gameData as NumMultiData;

      return sendPerformance(contestSession, gd.answers[0].toString(), score,
          startTime, endTime, context);
      break;
    case 'FindWordGame':
      final gd = gameData as MultiData;

      return sendPerformance(
          contestSession, gd.answers[0], score, startTime, endTime, context);
      break;
    case 'FingerGame':
      final gd = gameData as NumMultiData;

      return sendPerformance(contestSession, gd.answers[0].toString(), score,
          startTime, endTime, context);
      break;
    case 'JumbledWordsGame':
      final gd = gameData as MultiData;

      return sendPerformance(contestSession, gd.answers.toString(), score,
          startTime, endTime, context);
      break;
    case 'MatchTheShapeGame':
      final gd = gameData as MultiData;

      return sendPerformance(
          contestSession, gd.answers[0], score, startTime, endTime, context);
      break;
    case 'MatchWithImageGame':
      final gd = gameData as MultiData;

      return sendPerformance(
          contestSession, gd.answers[0], score, startTime, endTime, context);
      break;
    case 'MathOpGame':
      final gd = gameData as MathOpData;

      //  return sendPerformnce(contestSession, gd.answers[0].toString(), score,
      //     startTime, endTime, context);
      break;
    case 'MemoryGame':
      final gd = gameData as MultiData;

      return sendPerformance(
          contestSession, gd.answers[0], score, startTime, endTime, context);
      break;
    case 'OrderBySizeGame':
      final gd = gameData as NumMultiData;

      return sendPerformance(contestSession, gd.answers[0].toString(), score,
          startTime, endTime, context);
      break;
    case 'RecognizeNumberGame':
      final gd = gameData as NumMultiData;

      return sendPerformance(contestSession, gd.answers[0].toString(), score,
          startTime, endTime, context);
      break;
    case 'RhymeWordsGame':
      final gd = gameData as MultiData;

      return sendPerformance(
          contestSession, gd.answers[0], score, startTime, endTime, context);
      break;
    case 'SequenceAlphabetGame':
      final gd = gameData as MultiData;

      return sendPerformance(
          contestSession, gd.answers[0], score, startTime, endTime, context);
      break;
    case 'SequenceTheNumberGame':
      final gd = gameData as NumMultiData;

      return sendPerformance(contestSession, gd.answers[0].toString(), score,
          startTime, endTime, context);
      break;
    case 'TrueFalseGame':
      final gd = gameData as MultiData;

      return sendPerformance(contestSession, gd.answers[0].toString(), score,
          startTime, endTime, context);
      break;
  }
}

sendPerformance(QuizSession contestSession, String string, int score,
    DateTime startTime, DateTime endTime, BuildContext context) {
  final standardSerializers =
      (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
  final bool correct = score != 0 ? true : false;
  final studentId = StateContainer.of(context).studentIdVal;

  var timeStart = new DateTime.utc(
      startTime.year,
      startTime.month,
      startTime.day,
      startTime.day,
      startTime.hour,
      startTime.minute,
      startTime.second,
      startTime.millisecond);
  var timeEnd = new DateTime.utc(
      endTime.year,
      endTime.month,
      endTime.day,
      endTime.day,
      endTime.hour,
      endTime.minute,
      endTime.second,
      endTime.millisecond);

  Performance session = Performance((p) => p
    ..studentId = studentId
    ..gameId = contestSession.gameId
    ..sessionId = contestSession.sessionId
    ..level = contestSession.level
    ..question = "question we have to send"
    ..answer = string
    ..correct = correct
    ..score = score
    ..startTime = timeStart
    ..endTime = timeEnd);

  final json = standardSerializers.serialize(session);
  final jsonString = jsonEncode(json);
  final endPointId = StateContainer.of(context).quizSessionEndPointId;
  StateContainer.of(context).sendMessageTo(endPointId, jsonString);
}
