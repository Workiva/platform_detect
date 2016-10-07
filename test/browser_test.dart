@TestOn('vm')
import 'package:platform_detect/src/browser.dart';
import 'package:platform_detect/src/navigator.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

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
      Browser browser = new Browser(
          'Fake', (_) => true, (_) => new Version(1, 1, 0));
      expect(browser.name, 'Fake');
      expect(browser.version, new Version(1, 1, 0));
      expect(browser.isChrome, false);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, false);
    });

    test('Chrome', () {
      var navigator = new TestNavigator()
          ..userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36'
          ..appVersion = '5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36'
          ..vendor = 'Google Inc.';
      Browser.navigator = navigator;
      Browser browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Chrome');
      expect(browser.isChrome, true);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, false);
      expect(browser.version, new Version(53, 0, 2785, build: '143'));
    });

    test('Internet Explorer', () {
      var navigator = new TestNavigator()
          ..userAgent = 'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; rv:11.0) like Gecko'
          ..appVersion = '5.0 (Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; rv:11.0) like Gecko'
          ..appName = 'Netscape';
      Browser.navigator = navigator;
      Browser browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Internet Explorer');
      expect(browser.isChrome, false);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, true);
      expect(browser.version, new Version(11, 0, 0));
    });

    test('Firefox', () {
      var navigator = new TestNavigator()
          ..userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:48.0) Gecko/20100101 Firefox/48.0'
          ..appVersion = '5.0 (Macintosh)'
          ..appName = 'Netscape';
      Browser.navigator = navigator;
      Browser browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Firefox');
      expect(browser.isChrome, false);
      expect(browser.isFirefox, true);
      expect(browser.isSafari, false);
      expect(browser.isInternetExplorer, false);
      expect(browser.version, new Version(48, 0, 0));
    });

    test('Safari', () {
      var navigator = new TestNavigator()
          ..vendor = 'Apple Computer, Inc.'
          ..userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/9.1.3 Safari/601.7.8'
          ..appVersion = '5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/9.1.3 Safari/601.7.8'
          ..appName = 'Netscape';
      Browser.navigator = navigator;
      Browser browser = Browser.getCurrentBrowser();

      expect(browser.name, 'Safari');
      expect(browser.isChrome, false);
      expect(browser.isFirefox, false);
      expect(browser.isSafari, true);
      expect(browser.isInternetExplorer, false);
      expect(browser.version, new Version(9, 1, 3));
    });
  });
}
