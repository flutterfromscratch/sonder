import 'package:sonder/services/favourites.dart';

class MockedFavouritesService implements IFavouriteService {
  List<String> _favourites = List<String>();

  @override
  addToFavourite(String url) {
    _favourites.add(url);
  }

  @override
  getFavourites() {
    return _favourites;
  }

  @override
  init() {
    _favourites.clear();
  }

  @override
  removeFromFavourite(String url) {
    _favourites.removeWhere((element) => element == url);
  }
}
