import 'package:flutter_test/flutter_test.dart';
import 'package:sonder/services/time.dart';

void main() {
  TimeService timeService;

  setUp(() {
    timeService = TimeService();
  });

  group(('Tests the time service'), () {
    test('numbers lower than 12 are morning', () {
      final result = timeService.morningOrAfternoon(11);
      expect('M O R N I N G\r\n', result);
    });

    test('numbers more than 12 are the afternoon', () {
      final result = timeService.morningOrAfternoon(15);
      expect('A F T E R N O O N\r\n', result);
    });
  });
}
