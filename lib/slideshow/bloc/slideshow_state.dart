import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class SlideshowState extends Equatable {
  const SlideshowState();
}

class InitialSlideshowState extends SlideshowState {
  @override
  List<Object> get props => [];
}

class ImageLoadedState extends SlideshowState {
  final Uint8List imageBytes;

  ImageLoadedState(this.imageBytes);

  @override
  // TODO: implement props
  List<Object> get props => [imageBytes];
}

class DefineSonderState extends SlideshowState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
