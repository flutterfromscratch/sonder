import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonder/services/favourites.dart';
import 'package:sonder/slideshow/favourites/bloc/bloc.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
      ),
      body: BlocProvider(
        create: (c) =>
            FavouritesBloc(RepositoryProvider.of<FavouriteService>(context))
              ..add(LoadFavouritesEvent()),
        child: BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            if (state is FavouritesLoadedState) {
              return GridView.count(
                crossAxisCount: 2,
                children: state.favourites
                    .map((e) => Card(
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Image.network(
                                e,
                                fit: BoxFit.cover,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    print(e);
                                    BlocProvider.of<FavouritesBloc>(context)
                                        .add(RemoveFavouriteEvent(e));
                                  },
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
      ),
      body: GridView.count(crossAxisCount: null),
    );
  }
}
