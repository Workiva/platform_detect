@TestOn('vm')
import 'package:test/test.dart';

import 'package:platform_detect/src/navigator.dart';
import 'package:platform_detect/src/operating_system.dart';

final linux = new TestNavigator()..appVersion = 'Linux';
final mac = new TestNavigator()..appVersion = 'Macintosh';
final unix = new TestNavigator()..appVersion = 'X11';
final windows = new TestNavigator()..appVersion = 'Windows';

void main() {
  group('operating system detects', () {
    tearDown(() {
      OperatingSystem.navigator = null;
    });

    test('Unknown Operating System', () {
      OperatingSystem.navigator = new TestNavigator();
      var os = OperatingSystem.getCurrentOperatingSystem();
      expect(os.name, OperatingSystem.UnknownOS.name);
      expect(os.isMac, false);
      expect(os.isWindows, false);
      expect(os.isUnix, false);
      expect(os.isLinux, false);
    });

    test('Windows Operating System', () {
      OperatingSystem.navigator = windows;
      var os = OperatingSystem.getCurrentOperatingSystem();
      expect(os.name, 'Windows');
      expect(os.isMac, false);
      expect(os.isWindows, true);
      expect(os.isUnix, false);
      expect(os.isLinux, false);
    });

    test('Mac Operating System', () {
      OperatingSystem.navigator = mac;
      var os = OperatingSystem.getCurrentOperatingSystem();
      expect(os.name, 'Mac');
      expect(os.isMac, true);
      expect(os.isWindows, false);
      expect(os.isUnix, false);
      expect(os.isLinux, false);
    });

    test('Unix Operating System', () {
      OperatingSystem.navigator = unix;
      var os = OperatingSystem.getCurrentOperatingSystem();
      expect(os.name, 'Unix');
      expect(os.isMac, false);
      expect(os.isWindows, false);
      expect(os.isUnix, true);
      expect(os.isLinux, false);
    });

    test('Linux Operating System', () {
      OperatingSystem.navigator = linux;
      var os = OperatingSystem.getCurrentOperatingSystem();
      expect(os.name, 'Linux');
      expect(os.isMac, false);
      expect(os.isWindows, false);
      expect(os.isUnix, false);
      expect(os.isLinux, true);
    });
  });
}
