import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

@Timeout(const Duration(minutes: 2))
void main() {
  group('test navigation works', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) await driver.close();
    });

    test('to main photo slideshow', () async {
      await driver.runUnsynchronized(() async {
        final experienceButton = find.byValueKey('experienceButton');
        await driver.tap(experienceButton);
      });
    });

    test('to about page', () async {
      await driver.runUnsynchronized(() async {
        final aboutButton = find.byValueKey('aboutButton');
        driver.tap(aboutButton);
        await Future.delayed(Duration(seconds: 1));
        final aboutText = find.byValueKey('unsplashLicense');
        expect(await driver.getText(aboutText),
            'All pictures are provided by the unsplash source API, and are licensed by their respective authors.');
        await driver.tap(find.pageBack());
      });
    });

    test('favouriting photos and navigating to favourites page', () async {
      await driver.runUnsynchronized(() async {
        final favouritePhotoButton = find.byValueKey('favouritesButton');
        final nextPhotoButton = find.byValueKey('nextButton');
        final testFavouriteButton = find.byValueKey('testFavouritePhoto');
        for (int i = 0; i <= 2; i++) {
          driver.tap(nextPhotoButton);
          await Future.delayed(
              Duration(seconds: 8)); // give the photo time to transition
          driver.tap(testFavouriteButton);
          await Future.delayed(Duration(seconds: 1));
        }
        await driver.tap(favouritePhotoButton);
        // unfortunately there is no way in the Flutter Driver to
        // 'count' found widgets, so I will update this test in the
        // future when this is possible.
        await Future.delayed(Duration(seconds: 2));
        await driver.tap(find.pageBack());
      });
    }, timeout: Timeout(Duration(minutes: 2)));
  });
}
