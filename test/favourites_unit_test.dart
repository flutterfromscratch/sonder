import 'package:flutter_test/flutter_test.dart';
import 'package:sonder/services/favourites.dart';

import 'mocked/mockedfavourites.dart';

void main() {
  IFavouriteService favouriteService;
  setUp(() {
    favouriteService = MockedFavouritesService();
  });

  group('Tests favourites service', () {
    test('favourites are empty at the start', () {
      final favourites = favouriteService.getFavourites();
      expect(favourites.length, 0);
    });

    test('adding favourites increments the count of favourites', () {
      favouriteService.addToFavourite('testurl');
      favouriteService.addToFavourite('testurl2');
      favouriteService.addToFavourite('testurl3');
      expect(favouriteService.getFavourites().length, 3);
    });

    test('removing a favourite decreases the length by one', () {
      favouriteService.addToFavourite('testurl');
      favouriteService.addToFavourite('testurl2');
      favouriteService.addToFavourite('testurl3');
      favouriteService.removeFromFavourite('testurl2');
      expect(favouriteService.getFavourites().length, 2);
    });
  });
}
