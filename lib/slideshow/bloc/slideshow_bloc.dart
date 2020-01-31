import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import './bloc.dart';

class SlideshowBloc extends Bloc<SlideshowEvent, SlideshowState> {
//  Uint8List currentImageBytes;

  final http.Client _http = http.Client();

  Timer timer;
  @override
  SlideshowState get initialState => InitialSlideshowState();

  @override
  Stream<SlideshowState> mapEventToState(
    SlideshowEvent event,
  ) async* {
    if (event is InitEvent) {
      _stopTimer();
      yield (DefineSonderState());
    }
    if (event is StartSlideshowEvent) {
      _stopTimer();
      final startingImage = await rootBundle.load('assets/initial.jpg');
      yield (ImageLoadedState(startingImage.buffer.asUint8List()));
      await Future.delayed(Duration(seconds: 20));
      _startTimer();
    }
    if (event is ChangePictureEvent) {
//      final nextPicture = await _getRandomPictureUri();
      final nextPictureResponse = await _http
          .get('https://source.unsplash.com/random/1920x1080/?people,city');
      yield ImageLoadedState(nextPictureResponse.bodyBytes);
    }
  }

  _startTimer() {
    timer = Timer.periodic(Duration(seconds: 30), (timer) {
      add(ChangePictureEvent());
    });
  }

  _stopTimer() {
    timer?.cancel();
  }
}
