import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jamaica/screens/user_progress.dart';
import 'package:jamaica/state/state_container.dart';

void main() {
  testWidgets('user profile', (WidgetTester tester) async {
    print("just checking working or not ");

    var testKey = UniqueKey();

    await tester.pumpWidget(new MaterialApp(
      home: new Material(
        child: StateContainer(
          child: new UserProgress(
            key: testKey,
          ),
        ),
      ),
    ));

    expect(find.byKey(testKey), findsOneWidget);
    // await tester.pump(Duration(seconds: 5));
  });
  // testWidgets('ListView itemExtent control test', (WidgetTester tester) async {
  //   await tester.pumpWidget(
  //     Directionality(
  //       textDirection: TextDirection.ltr,
  //       child: ListView(
  //         itemExtent: 200.0,
  //         children: List<Widget>.generate(20, (int i) {
  //           return Container(
  //             child: Text('$i'),
  //           );
  //         }),
  //       ),
  //     ),
  //   );

  //   final RenderBox box = tester.renderObject<RenderBox>(find.byType(Container).first);
  //   expect(box.size.height, equals(200.0));

  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsOneWidget);
  //   expect(find.text('2'), findsOneWidget);
  //   expect(find.text('3'), findsNothing);
  //   expect(find.text('4'), findsNothing);

  //   await tester.drag(find.byType(ListView), const Offset(0.0, -250.0));
  //   await tester.pump();

  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  //   expect(find.text('2'), findsOneWidget);
  //   expect(find.text('3'), findsOneWidget);
  //   expect(find.text('4'), findsOneWidget);
  //   expect(find.text('5'), findsNothing);
  //   expect(find.text('6'), findsNothing);

  //   await tester.drag(find.byType(ListView), const Offset(0.0, 200.0));
  //   await tester.pump();

  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsOneWidget);
  //   expect(find.text('2'), findsOneWidget);
  //   expect(find.text('3'), findsOneWidget);
  //   expect(find.text('4'), findsNothing);
  //   expect(find.text('5'), findsNothing);
  // });
}
