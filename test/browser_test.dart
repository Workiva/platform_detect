@TestOn('vm')
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import 'package:platform_detect/src/browser.dart';
import 'package:platform_detect/src/navigator.dart';
import './constants.dart';

void main() {
  late Browser browser;

  group('browser detects', () {
    tearDown(() {
      browser.clearVersion();
      Browser.navigator = null;
    });

    test('Unknown Browser', () {
      Browser.navigator = TestNavigator();
      browser = Browser.getCurrentBrowser();
      expect(browser.name, Browser.UnknownBrowser.name);
      expect(browser.version, Browser.UnknownBrowser.version);
      expect(browser.isChrome, false);
      expect(browser.isEdgeChrome, isFalse);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, false);
    });

    test('Fake Browser', () {
      browser = Browser('Fake', (_) => true, (_) => Version(1, 1, 0));
      expect(browser.name, 'Fake');
      expect(browser.version, Version(1, 1, 0));
      expect(browser.isChrome, false);
      expect(browser.isEdgeChrome, isFalse);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, false);
    });

    test('Chrome', () {
      Browser.navigator = testChrome();
      browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Chrome');
      expect(browser.isChrome, true);
      expect(browser.isEdgeChrome, isFalse);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, false);
      expect(browser.version, Version(53, 0, 2785, build: '143'));
    });

    test('Edge Chrome', () {
      Browser.navigator = testChromeEdge();
      browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Edge');
      expect([browser.isChrome, browser.isEdgeChrome], everyElement(isTrue),
          reason:
              'Blink-based Edge browser should be detected as both Chrome and Edge '
              'since feature support is based on Chrome, but should identify as Edge '
              'for logging purposes');
      expect(browser.isFirefox, isFalse);
      expect(browser.isSafari, isFalse);
      expect(browser.isInternetExplorer, isFalse);
      expect(browser.version, Version(91, 0, 864, build: '59'));

      expect(browser, isA<EdgeChrome>());
      expect(
        (browser as EdgeChrome).chromeVersion,
        Version(91, 0, 4472, build: '124'),
      );
    });

    test('Chromeless', () {
      Browser.navigator = testChromeless();
      browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Chrome');
      expect(browser.isChrome, true);
      expect(browser.isEdgeChrome, isFalse);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, false);
      expect(browser.version, Version(0, 0, 0));
    });

    test('Internet Explorer', () {
      Browser.navigator = testInternetExplorer();
      browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Internet Explorer');
      expect(browser.isChrome, false);
      expect(browser.isEdgeChrome, isFalse);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, true);
      expect(browser.version, Version(11, 0, 0));
    });

    test('Internet Explorer (Edge)', () {
      Browser.navigator = testInternetExplorerEdge();
      browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Internet Explorer');
      expect(browser.isChrome, isFalse);
      expect(browser.isEdgeChrome, isFalse);
      expect(browser.isFirefox, isFalse);
      expect(browser.isSafari, isFalse);
      expect(browser.isInternetExplorer, isTrue);
      expect(browser.version, Version(12, 10136, 0));
    });

    test('Firefox', () {
      Browser.navigator = testFirefox();
      browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Firefox');
      expect(browser.isChrome, false);
      expect(browser.isEdgeChrome, isFalse);
      expect(browser.isFirefox, true);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, false);
      expect(browser.version, Version(48, 0, 0));
    });

    group('Safari', () {
      tearDown(() {
        Browser.navigator = null;
      });

      test('major, minor and patch version', () {
        Browser.navigator = testSafari();
        browser = Browser.getCurrentBrowser();

        expect(browser.name, 'Safari');
        expect(browser.isChrome, false);
        expect(browser.isEdgeChrome, isFalse);
        expect(browser.isFirefox, false);
        expect(browser.isSafari, true);
        expect(browser.isInternetExplorer, false);
        expect(browser.version, Version(9, 1, 3));
      });

      test('major and minor version', () {
        Browser.navigator = testSafari(
            userAgent: safariUserAgentWithoutPatchTestString,
            appVersion: safariAppVersionWithoutPatchTestString);
        browser = Browser.getCurrentBrowser();
        browser.clearVersion();

        expect(browser.name, 'Safari');
        expect(browser.isChrome, false);
        expect(browser.isEdgeChrome, isFalse);
        expect(browser.isFirefox, false);
        expect(browser.isSafari, true);
        expect(browser.isInternetExplorer, false);
        expect(browser.version, Version(10, 1, 0));
      });

      test('only a major version', () {
        Browser.navigator = testSafari(
            userAgent: safariUserAgentWithoutMinorTestString,
            appVersion: safariAppVersionWithoutMinorTestString);
        browser = Browser.getCurrentBrowser();
        browser.clearVersion();

        expect(browser.name, 'Safari');
        expect(browser.isChrome, false);
        expect(browser.isEdgeChrome, isFalse);
        expect(browser.isFirefox, false);
        expect(browser.isSafari, true);
        expect(browser.isInternetExplorer, false);
        expect(browser.version, Version(11, 0, 0));
      });
    });

    test('WKWebView', () {
      Browser.navigator = testWkWebView();
      browser = Browser.getCurrentBrowser();

      expect(browser.name, 'WKWebView');
      expect(browser.isChrome, false);
      expect(browser.isEdgeChrome, isFalse);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isWKWebView, true);
      expect(browser.isInternetExplorer, false);
      expect(browser.version, Version(601, 7, 8));
    });
  });
}
