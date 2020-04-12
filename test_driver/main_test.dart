import 'package:flutter_driver/flutter_driver.dart';
import 'package:screenshots/screenshots.dart';
import 'package:test/test.dart';

void main() {
  group('testing app', () {
    FlutterDriver driver;
    final config = Config();

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      print('welcome to test');
    });

    tearDownAll(() async {
      if (driver != null) await driver.close();
    });

    group('test functionality', () {});

    group('take screenshots for store', () {
      test('tap on experience', () async {
        await driver.runUnsynchronized(() async {
          final experienceButton = find.byValueKey('experienceButton');
          await screenshot(driver, config, 'start',
              waitUntilNoTransientCallbacks: false);
          await driver.tap(experienceButton);
        });
      });

      test('tap on about', () async {
        await driver.runUnsynchronized(() async {
          final aboutButton = find.byValueKey('aboutButton');
          driver.tap(aboutButton);

          await screenshot(driver, config, 'aboutscreen',
              waitUntilNoTransientCallbacks: false);
        });
      });

      test('wait for the next picture to show up', () async {
        await driver.runUnsynchronized(() async {
          await Future.delayed(Duration(seconds: 20));
          await screenshot(driver, config, 'nextPicture',
              waitUntilNoTransientCallbacks: false);
        });
      });
    });
  });
}
