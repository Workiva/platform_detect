library platform_detect.browser;

import 'package:pub_semver/pub_semver.dart';
import 'package:platform_detect/src/navigator.dart';

/// Matches a browser name with how it is represented in window.navigator
class Browser {
  static NavigatorProvider navigator;

  static Browser getCurrentBrowser() {
    return _knownBrowsers.firstWhere(
        (browser) => browser._matchesNavigator(navigator),
        orElse: () => UnknownBrowser);
  }

  static Browser UnknownBrowser = new Browser('Unknown', null, null);

  Browser(this.name, bool matchesNavigator(NavigatorProvider navigator),
      Version parseVersion(NavigatorProvider navigator))
      : this._matchesNavigator = matchesNavigator,
        this._parseVersion = parseVersion;

  final String name;
  final Function _matchesNavigator;
  final Function _parseVersion;

  Version _version;

  Version get version {
    if (_version == null) {
      if (_parseVersion != null) {
        _version = _parseVersion(Browser.navigator);
      } else {
        _version = new Version(0, 0, 0);
      }
    }

    return _version;
  }

  static List<Browser> _knownBrowsers = [
    _chrome,
    _firefox,
    _safari,
    _internetExplorer,
    _wkWebView
  ];

  bool get isChrome => this == _chrome;
  bool get isFirefox => this == _firefox;
  bool get isSafari => this == _safari;
  bool get isInternetExplorer => this == _internetExplorer;
  bool get isWKWebView => this == _wkWebView;
}

Browser _chrome = new _Chrome();
Browser _firefox = new _Firefox();
Browser _safari = new _Safari();
Browser _internetExplorer = new _InternetExplorer();
Browser _wkWebView = new _WKWebView();

class _Chrome extends Browser {
  _Chrome() : super('Chrome', _isChrome, _getVersion);

  static bool _isChrome(NavigatorProvider navigator) {
    var vendor = navigator.vendor;
    return vendor != null && vendor.contains('Google');
  }

  static Version _getVersion(NavigatorProvider navigator) {
    Match match = new RegExp(r"Chrome/(\d+)\.(\d+)\.(\d+)\.(\d+)\s")
        .firstMatch(navigator.appVersion);
    var major = int.parse(match.group(1));
    var minor = int.parse(match.group(2));
    var patch = int.parse(match.group(3));
    var build = match.group(4);
    return new Version(major, minor, patch, build: build);
  }
}

class _Firefox extends Browser {
  _Firefox() : super('Firefox', _isFirefox, _getVersion);

  static bool _isFirefox(NavigatorProvider navigator) {
    return navigator.userAgent.contains('Firefox');
  }

  static Version _getVersion(NavigatorProvider navigator) {
    Match match =
        new RegExp(r'rv:(\d+)\.(\d+)\)').firstMatch(navigator.userAgent);
    var major = int.parse(match.group(1));
    var minor = int.parse(match.group(2));
    return new Version(major, minor, 0);
  }
}

class _Safari extends Browser {
  _Safari() : super('Safari', _isSafari, _getVersion);

  static bool _isSafari(NavigatorProvider navigator) {
    // An web view running in an iOS app does not have a 'Version/X.X.X' string in the appVersion
    return navigator.vendor.contains('Apple') && navigator.appVersion.contains('Version');
  }

  static Version _getVersion(NavigatorProvider navigator) {
    Match match = new RegExp(r'Version/(\d+)\.(\d+)\.(\d+)')
        .firstMatch(navigator.appVersion);
    var major = int.parse(match.group(1));
    var minor = int.parse(match.group(2));
    var patch = int.parse(match.group(3));
    return new Version(major, minor, patch);
  }
}

class _WKWebView extends Browser {
  _WKWebView(): super('WKWebView', _isWKWebView, _getVersion);

  static bool _isWKWebView(NavigatorProvider navigator) {
    // An web view running in an iOS app does not have a 'Version/X.X.X' string in the appVersion
    return navigator.vendor.contains('Apple') && !navigator.appVersion.contains('Version');
  }

  static Version _getVersion(NavigatorProvider navigator) {
    Match match = new RegExp(r'AppleWebKit/(\d+)\.(\d+)\.(\d+)')
        .firstMatch(navigator.appVersion);
    var major = int.parse(match.group(1));
    var minor = int.parse(match.group(2));
    var patch = int.parse(match.group(3));
    return new Version(major, minor, patch);
  }
}

class _InternetExplorer extends Browser {
  _InternetExplorer()
      : super('Internet Explorer', _isInternetExplorer, _getVersion);

  static bool _isInternetExplorer(NavigatorProvider navigator) {
    return navigator.appName.contains('Microsoft') ||
        navigator.appVersion.contains('Trident') ||
        navigator.appVersion.contains('Edge');
  }

  static Version _getVersion(NavigatorProvider navigator) {
    Match match =
        new RegExp(r'MSIE (\d+)\.(\d+);').firstMatch(navigator.appVersion);
    if (match != null) {
      var major = int.parse(match.group(1));
      var minor = int.parse(match.group(2));
      return new Version(major, minor, 0);
    }

    match = new RegExp(r'rv[: ](\d+)\.(\d+)').firstMatch(navigator.appVersion);
    if (match != null) {
      var major = int.parse(match.group(1));
      var minor = int.parse(match.group(2));
      return new Version(major, minor, 0);
    }

    match = new RegExp(r'Edge/(\d+)\.(\d+)$').firstMatch(navigator.appVersion);
    if (match != null) {
      var major = int.parse(match.group(1));
      var minor = int.parse(match.group(2));
      return new Version(major, minor, 0);
    }

    return new Version(0, 0, 0);
  }
}
