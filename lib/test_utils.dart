import 'package:platform_detect/src/browser.dart';
import 'package:platform_detect/src/navigator.dart';
import 'package:platform_detect/src/operating_system.dart';

class BrowserNavigators {
  static final NavigatorProvider chrome = new TestNavigator()
    ..userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36'
    ..appVersion = '5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36'
    ..vendor = 'Google Inc.';
  static final NavigatorProvider firefox = new TestNavigator()
    ..userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:48.0) Gecko/20100101 Firefox/48.0'
    ..appVersion = '5.0 (Macintosh)'
    ..appName = 'Netscape';
  static final NavigatorProvider internetExplorer = new TestNavigator()
    ..userAgent = 'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; rv:11.0) like Gecko'
    ..appVersion = '5.0 (Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; rv:11.0) like Gecko'
    ..appName = 'Netscape';
  static final NavigatorProvider safari = new TestNavigator()
    ..vendor = 'Apple Computer, Inc.'
    ..userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/9.1.3 Safari/601.7.8'
    ..appVersion = '5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/9.1.3 Safari/601.7.8'
    ..appName = 'Netscape';
  static final NavigatorProvider wkWebView = new TestNavigator()
    ..vendor = 'Apple Computer, Inc.'
    ..userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/9.1.3 Safari/601.7.8'
    ..appVersion = '5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Safari/601.7.8'
    ..appName = 'Netscape';

  /// Set the [NavigatorProvider] that will be used to determine the
  /// current browser.
  static void set(NavigatorProvider provider) {
    Browser.navigator = provider;
  }
}

class OperatingSystemNavigators {
  static final NavigatorProvider linux = new TestNavigator()..appVersion = 'Linux';
  static final NavigatorProvider mac = new TestNavigator()..appVersion = 'Macintosh';
  static final NavigatorProvider unix = new TestNavigator()..appVersion = 'X11';
  static final NavigatorProvider windows = new TestNavigator()..appVersion = 'Windows';

  /// Set the [NavigatorProvider] that will be used to determine the
  /// current operating system.
  static void set(NavigatorProvider provider) {
    OperatingSystem.navigator = provider;
  }
}
