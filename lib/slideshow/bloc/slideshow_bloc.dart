import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sonder/asset_loader.dart';
import 'package:sonder/services/favourites.dart';

import './bloc.dart';

class SlideshowBloc extends Bloc<SlideshowEvent, SlideshowState> {
  SlideshowBloc(this.assetLoader, this.favouriteService);

  final AssetLoader assetLoader;
  final FavouriteService favouriteService;

  final http.Client _http = http.Client();

  Timer timer;
  @override
  SlideshowState get initialState => InitialSlideshowState();

  @override
  Stream<SlideshowState> mapEventToState(
    SlideshowEvent event,
  ) async* {
    if (event is InitEvent) {
      await favouriteService.init();
      _stopTimer();
      yield (DefineSonderState());
    }
    if (event is StartSlideshowEvent) {
      _stopTimer();
      print('loading local image');
      final startingImage = await assetLoader.load('assets/initial.jpg');
      yield (ImageLoadedState(startingImage.buffer.asUint8List()));
      _startTimer();
    }
    if (event is ChangePictureEvent) {
      _stopTimer();
      _startTimer();
      final address = await getPictureUrl(
          "https://source.unsplash.com/random/1920x1080/?cats");

//      final nextPicture = await _getRandomPictureUri();
      final nextPictureResponse = await _http.get(address);
      yield ImageLoadedState(nextPictureResponse.bodyBytes, imageUrl: address);
    }
    if (event is AddFavouriteEvent) {
      favouriteService.addToFavourite(event.favouriteUrl);
    }
  }

  _startTimer() {
    print('starting timer');
    timer = Timer.periodic(Duration(seconds: 30), (timer) {
      add(ChangePictureEvent());
    });
  }

  _stopTimer() {
    timer?.cancel();
  }

  Future<String> getPictureUrl(String url) async {
    final address = Request(
      'GET',
      Uri.parse('https://source.unsplash.com/random/1920x1080/?cats'),
    )..followRedirects = false;
    try {
      final response = await _http.send(address);
      final actualAddress = response.headers['location'];

      print(actualAddress);
      return actualAddress;
    } on Exception catch (ex) {}
  }
}
