import 'dart:async';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

const Duration kWaitBetweenActions = const Duration(milliseconds: 500);

void main() {
  group('login', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) await driver.close();
    });
  

  test('story', () async {
    await new Future<Null>.delayed(kWaitBetweenActions);
    final SerializableFinder story = find.byValueKey('story');
    await driver.tap(story);

    for(int n=0;n<3;n++){
        await new Future<Null>.delayed(kWaitBetweenActions);
        String tile=n.toString();
        final SerializableFinder storynum = find.byValueKey(tile);
        await driver.tap(storynum);
        final SerializableFinder scroll = find.byValueKey('scroll');
        await driver.scroll(scroll, 0.0, -300.0, const Duration(milliseconds: 300));
        await new Future<Null>.delayed(kWaitBetweenActions);
        await driver.scroll(scroll, -300.0, 0.0, const Duration(milliseconds: 300));
        await new Future<Null>.delayed(kWaitBetweenActions);
        await driver.tap(find.byTooltip('Back'));
        
      }
    });
  });
}