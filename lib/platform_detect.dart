/// Enables detection of browser type and version and operating system
///
/// Use browser.isChrome or operatingSystem.isMac
library platform_detect;

import 'dart:html';

import 'package:platform_detect/src/browser.dart';
import 'package:platform_detect/src/navigator.dart';
import 'package:platform_detect/src/operating_system.dart';

Browser _browser;

/// Current browser info
Browser get browser {
  if (_browser == null) {
    Browser.navigator = new _HtmlNavigator();
    _browser = Browser.getCurrentBrowser();
  }

  return _browser;
}

OperatingSystem _operatingSystem;

/// Current operating system info
OperatingSystem get operatingSystem {
  if (_operatingSystem == null) {
    OperatingSystem.navigator = new _HtmlNavigator();
    _operatingSystem = OperatingSystem.getCurrentOperatingSystem();
  }

  return _operatingSystem;
}

class _HtmlNavigator implements NavigatorProvider {
  String get vendor => window.navigator.vendor;
  String get appVersion => window.navigator.appVersion;
  String get appName => window.navigator.appName;
  String get userAgent => window.navigator.userAgent;
}
