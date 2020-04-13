import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IFavouriteService {
  init();
  addToFavourite(String url);
  removeFromFavourite(String url);
  List<String> getFavourites();
}

class FavouriteService implements IFavouriteService {
  Box<String> favouritesBox;

  init() async {
    await Hive.initFlutter();
    favouritesBox = await Hive.openBox('favourites');
  }

  addToFavourite(String url) async {
    await favouritesBox.add(url);
    print('added ' + url);
  }

  removeFromFavourite(String url) async {
    final index = favouritesBox.values.toList().indexOf(url);

    await favouritesBox.deleteAt(index);
//    final favourite = favouritesBox.values.where((element) => element == url);
  }

  List<String> getFavourites() {
    return favouritesBox.values.toList(growable: false);
  }
}
