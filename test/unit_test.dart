import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sonder/slideshow/bloc/bloc.dart';

class MockSlideshowBloc<SlideshowEvent, SlideshowState> extends MockBloc<SlideshowEvent, SlideshowBloc>
    implements SlideshowBloc {}

void main() {
  blocTest('bloc yields nothing on start',
      build: () async => SlideshowBloc(), wait: const Duration(seconds: 1), expect: []);

  test('emits image loaded when experience is tapped', () async {
    final bloc = SlideshowBloc();
    bloc.add(StartSlideshowEvent());
    await emitsExactly(bloc, [ImageLoadedState]);
  });
}
