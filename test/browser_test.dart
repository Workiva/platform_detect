@TestOn('vm')
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import 'package:platform_detect/src/browser.dart';
import 'package:platform_detect/src/navigator.dart';
import './constants.dart';

void main() {
  group('browser detects', () {
    tearDown(() {
      Browser.navigator = null;
    });

    test('Unknown Browser', () {
      Browser.navigator = new TestNavigator();
      var browser = Browser.getCurrentBrowser();
      expect(browser.name, Browser.UnknownBrowser.name);
      expect(browser.version, Browser.UnknownBrowser.version);
      expect(browser.isChrome, false);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, false);
    });

    test('Fake Browser', () {
      Browser browser =
          new Browser('Fake', (_) => true, (_) => new Version(1, 1, 0));
      expect(browser.name, 'Fake');
      expect(browser.version, new Version(1, 1, 0));
      expect(browser.isChrome, false);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, false);
    });

    test('Chrome', () {
      Browser.navigator = testChrome();
      Browser browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Chrome');
      expect(browser.isChrome, true);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, false);
      expect(browser.version, new Version(53, 0, 2785, build: '143'));
    });

    test('Internet Explorer', () {
      Browser.navigator = testInternetExplorer();
      Browser browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Internet Explorer');
      expect(browser.isChrome, false);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, true);
      expect(browser.version, new Version(11, 0, 0));
    });

    test('Firefox', () {
      Browser.navigator = testFirefox();
      Browser browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Firefox');
      expect(browser.isChrome, false);
      expect(browser.isFirefox, true);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, false);
      expect(browser.version, new Version(48, 0, 0));
    });

    test('Safari', () {
      Browser.navigator = testSafari();
      Browser browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Safari');
      expect(browser.isChrome, false);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, true);
      expect(browser.isInternetExplorer, false);
      expect(browser.version, new Version(9, 1, 3));
    });

    test('WKWebView', () {
      Browser.navigator = testWkWebView();
      Browser browser = Browser.getCurrentBrowser();

      expect(browser.name, 'WKWebView');
      expect(browser.isChrome, false);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isWKWebView, true);
      expect(browser.isInternetExplorer, false);
      expect(browser.version, new Version(601, 7, 8));
    });
  });
}
