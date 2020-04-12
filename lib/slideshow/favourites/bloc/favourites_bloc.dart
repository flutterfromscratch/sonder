import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sonder/services/favourites.dart';

import './bloc.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final FavouriteService favouriteService;

  FavouritesBloc(this.favouriteService);

  @override
  FavouritesState get initialState => InitialFavouritesState();

  @override
  Stream<FavouritesState> mapEventToState(
    FavouritesEvent event,
  ) async* {
    if (event is LoadFavouritesEvent) {
      final favourites = favouriteService.getFavourites();
      yield FavouritesLoadedState(favourites);
    }
    if (event is RemoveFavouriteEvent) {
      await favouriteService.removeFromFavourite(event.uriToRemove);
      add(LoadFavouritesEvent());
    }
    // TODO: Add Logic
  }
}
