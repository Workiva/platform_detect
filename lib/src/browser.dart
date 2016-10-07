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
    _internetExplorer
  ];

  bool get isChrome => this == _chrome;
  bool get isFirefox => this == _firefox;
  bool get isSafari => this == _safari;
  bool get isInternetExplorer => this == _internetExplorer;

  static Browser _chrome = new Browser('Chrome', (NavigatorProvider navigator) {
    var vendor = navigator.vendor;
    return vendor != null && vendor.contains('Google');
  }, (NavigatorProvider navigator) {
    Match match = new RegExp(r"Chrome/(\d+)\.(\d+)\.(\d+)\.(\d+)\s")
        .firstMatch(navigator.appVersion);
    var major = int.parse(match.group(1));
    var minor = int.parse(match.group(2));
    var patch = int.parse(match.group(3));
    var build = match.group(4);
    return new Version(major, minor, patch, build: build);
  });

  static Browser _firefox =
      new Browser('Firefox', (NavigatorProvider navigator) {
    return navigator.userAgent.contains('Firefox');
  }, (NavigatorProvider navigator) {
    Match match =
        new RegExp(r'rv:(\d+)\.(\d+)\)').firstMatch(navigator.userAgent);
    var major = int.parse(match.group(1));
    var minor = int.parse(match.group(2));
    return new Version(major, minor, 0);
  });

  static Browser _safari = new Browser('Safari', (NavigatorProvider navigator) {
    return navigator.vendor.contains('Apple');
  }, (NavigatorProvider navigator) {
    Match match = new RegExp(r'Version/(\d+)\.(\d+)\.(\d+)')
        .firstMatch(navigator.appVersion);
    var major = int.parse(match.group(1));
    var minor = int.parse(match.group(2));
    var patch = int.parse(match.group(3));
    return new Version(major, minor, patch);
  });

  static Browser _internetExplorer =
      new Browser('Internet Explorer', (NavigatorProvider navigator) {
    return navigator.appName.contains('Microsoft') ||
        navigator.appVersion.contains('Trident') ||
        navigator.appVersion.contains('Edge');
  }, (NavigatorProvider navigator) {
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
  });
}
