import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jamaica/widgets/theme_map.dart';

void main() {
  const Duration _frameDuration = Duration(milliseconds: 100);
  List<String> _listItems = [
    'House',
    'Sports',
    'Gym',
    'Play Ground',
    'Cycle',
    'College',
    'School',
    'Teacher',
    'Book',
    'Cricket',
  ];

  testWidgets('Theme Map test case pass', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: ThemeMap(),
    )));

    // Verify that our counter starts at 0.
    expect(find.byKey(Key('ThemeMap')), findsOneWidget);
    expect(find.byKey(Key('BackGroundImage0')), findsOneWidget);
    expect(find.byKey(Key('Icon0')), findsOneWidget);
    expect(find.byKey(Key('Icon1')), findsOneWidget);
    expect(find.byKey(Key('Icon2')), findsOneWidget);
    expect(find.byKey(Key('Icon3')), findsOneWidget);
    expect(find.byKey(Key('Icon4')), findsOneWidget);

    for (int i = 0; i < _listItems.length / 2; i++) {
      expect(find.text(_listItems[i]), findsOneWidget);
    }
    await tester.press(find.byKey(Key('Icon0')));
    await tester.press(find.byKey(Key('Icon1')));
    await tester.press(find.byKey(Key('Icon2')));
    await tester.press(find.byKey(Key('Icon3')));
    await tester.press(find.byKey(Key('Icon4')));
    await tester.pump();
  });
}
