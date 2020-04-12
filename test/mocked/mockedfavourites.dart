import '../../lib/services/favourites.dart';

class MockedFavouritesService implements IFavouriteService {
  List<String> _favourites;

  @override
  addToFavourite(String url) {
    // TODO: implement addToFavourite
    _favourites.add(url);

//    throw UnimplementedError();
  }

  @override
  getFavourites() {
    return _favourites;
    // TODO: implement getFavourites
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
