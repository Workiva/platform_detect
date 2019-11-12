@TestOn('browser')
import 'package:platform_detect/src/support.dart';
import 'package:test/test.dart';

void main() {
  group('Feature.touchEvents', () {
    test('is false on Chrome desktop (which we can assume CI is using)', () {
      expect(Feature.touchEvents.isSupported, isFalse);
    }, testOn: 'chrome');
  });
}
