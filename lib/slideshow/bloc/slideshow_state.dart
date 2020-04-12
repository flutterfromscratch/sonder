import 'dart:typed_data';

import 'package:equatable/equatable.dart';

abstract class SlideshowState extends Equatable {
  const SlideshowState();

  @override
  List<Object> get props => [];
}

class InitialSlideshowState extends SlideshowState {}

class ImageLoadedState extends SlideshowState {
  final Uint8List imageBytes;
  final String imageUrl;

  ImageLoadedState(this.imageBytes, {this.imageUrl});

  @override
  List<Object> get props => [imageBytes];
}

class DefineSonderState extends SlideshowState {}
