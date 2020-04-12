import 'package:equatable/equatable.dart';

abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();
}

class LoadFavouritesEvent extends FavouritesEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RemoveFavouriteEvent extends FavouritesEvent{
  final String uriToRemove;

  RemoveFavouriteEvent(this.uriToRemove);

  @override
  // TODO: implement props
  List<Object> get props => [uriToRemove];

}