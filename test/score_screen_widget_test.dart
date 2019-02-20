import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jamaica/screens/score_screen.dart';

void main() {
  testWidgets('score screen', (WidgetTester tester) async {
    print("widget testingg for Score screen ");
    Key testKey = UniqueKey();
    await tester.pumpWidget(new MaterialApp(
      home: new Material(
        child: new ScoreScreen(
          key: testKey,
          score: 100,
          coinsCount: 20,
          starCount: 5,
        ),
      ),
    ));
    expect(find.byKey(testKey), findsOneWidget);
    await tester.pump(Duration(seconds: 5));
     await tester.tap(find.byType(InkWell).first);
    await tester.pump();
  });

}

