import 'package:equatable/equatable.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();
}

class InitialFavouritesState extends FavouritesState {
  @override
  List<Object> get props => [];
}

class FavouritesLoadedState extends FavouritesState {
  final List<String> favourites;

  FavouritesLoadedState(this.favourites);

  @override
  // TODO: implement props
  List<Object> get props => [favourites];
}
