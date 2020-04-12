import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonder/asset_loader.dart';
import 'package:sonder/services/favourites.dart';
import 'package:sonder/services/time.dart';
import 'package:sonder/slideshow/bloc/bloc.dart';
import 'package:sonder/slideshow/slideshow.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TimeService>(
          create: (context) => TimeService(),
        ),
        RepositoryProvider<FavouriteService>(
          create: (context) => FavouriteService(),
        )
      ],
      child: MaterialApp(
        title: 'Sonder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          child: SlideshowPage(),
          providers: [
            BlocProvider<SlideshowBloc>(
              create: (context) => SlideshowBloc(AssetLoader(),
                  RepositoryProvider.of<FavouriteService>(context))
                ..add(InitEvent()),
            ),
          ],
        ),
//        child: MultiBlocProvider(
//          child: SlideshowPage(),
//          providers: [
//            BlocProvider<SlideshowBloc>(
//              create: (context) => SlideshowBloc(AssetLoader(),
//                  RepositoryProvider.of<FavouriteService>(context))
//                ..add(InitEvent()),
//            ),
//          ],
//        ),
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}
