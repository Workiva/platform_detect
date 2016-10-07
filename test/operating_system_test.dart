@TestOn('vm')
import 'package:platform_detect/src/operating_system.dart';
import 'package:platform_detect/src/navigator.dart';
import 'package:test/test.dart';

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
      OperatingSystem.navigator = new TestNavigator()..appVersion = 'Windows';
      var os = OperatingSystem.getCurrentOperatingSystem();
      expect(os.name, 'Windows');
      expect(os.isMac, false);
      expect(os.isWindows, true);
      expect(os.isUnix, false);
      expect(os.isLinux, false);
    });

    test('Mac Operating System', () {
      OperatingSystem.navigator = new TestNavigator()..appVersion = 'Macintosh';
      var os = OperatingSystem.getCurrentOperatingSystem();
      expect(os.name, 'Mac');
      expect(os.isMac, true);
      expect(os.isWindows, false);
      expect(os.isUnix, false);
      expect(os.isLinux, false);
    });

    test('Unix Operating System', () {
      OperatingSystem.navigator = new TestNavigator()..appVersion = 'X11';
      var os = OperatingSystem.getCurrentOperatingSystem();
      expect(os.name, 'Unix');
      expect(os.isMac, false);
      expect(os.isWindows, false);
      expect(os.isUnix, true);
      expect(os.isLinux, false);
    });

    test('Linux Operating System', () {
      OperatingSystem.navigator = new TestNavigator()..appVersion = 'Linux';
      var os = OperatingSystem.getCurrentOperatingSystem();
      expect(os.name, 'Linux');
      expect(os.isMac, false);
      expect(os.isWindows, false);
      expect(os.isUnix, false);
      expect(os.isLinux, true);
    });
  });
}
