@TestOn('browser')
import 'package:test/test.dart';

import 'package:platform_detect/platform_detect.dart';
import 'package:platform_detect/test_utils.dart';

void main() {
  group('platform detect test utils', () {
    test('should set chrome', () {
      configurePlatformForTesting(browser: chrome);
      expect(browser.isChrome, isTrue);
    });

    test('should set firefox', () {
      configurePlatformForTesting(browser: firefox);
      expect(browser.isFirefox, isTrue);
    });

    test('should set internet explorer', () {
      configurePlatformForTesting(browser: internetExplorer);
      expect(browser.isInternetExplorer, isTrue);
    });

    test('should set safari', () {
      configurePlatformForTesting(browser: safari);
      expect(browser.isSafari, isTrue);
    });

    test('should set wkwebview', () {
      configurePlatformForTesting(browser: wkWebView);
      expect(browser.isWKWebView, isTrue);
    });

    test('should set linux', () {
      configurePlatformForTesting(operatingSystem: linux);
      expect(operatingSystem.isLinux, isTrue);
    });

    test('should set mac', () {
      configurePlatformForTesting(operatingSystem: mac);
      expect(operatingSystem.isMac, isTrue);
    });

    test('should set unix', () {
      configurePlatformForTesting(operatingSystem: unix);
      expect(operatingSystem.isUnix, isTrue);
    });

    test('should set windows', () {
      configurePlatformForTesting(operatingSystem: windows);
      expect(operatingSystem.isWindows, isTrue);
    });
  });
}
