import 'package:equatable/equatable.dart';

abstract class SlideshowEvent extends Equatable {
  const SlideshowEvent();
}

class InitEvent extends SlideshowEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChangePictureEvent extends SlideshowEvent {
//  final Uint8List pictureBytes;
//  final bool isFirst;

  ChangePictureEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class StartSlideshowEvent extends SlideshowEvent {
  StartSlideshowEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}
