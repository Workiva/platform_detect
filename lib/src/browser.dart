// Copyright 2017 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:meta/meta.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:platform_detect/src/navigator.dart';

/// Matches a browser name with how it is represented in window.navigator
class Browser {
  static NavigatorProvider? navigator;

  static Browser getCurrentBrowser() {
    return _knownBrowsers.firstWhere(
        (browser) => browser._matchesNavigator(navigator),
        orElse: () => UnknownBrowser);
  }

  @visibleForTesting
  clearVersion() => _version = null;

  static Browser UnknownBrowser =
      Browser('Unknown', (_) => false, (_) => Version(0, 0, 0));

  Browser(this.name, bool this._matchesNavigator(NavigatorProvider navigator),
      Version this._parseVersion(NavigatorProvider navigator),
      {this.className = ''});

  final String name;

  /// The CSS class value that should be used instead of lowercase [name] (optional).
  final String className;
  final Function _matchesNavigator;
  final Function _parseVersion;

  Version? _version;

  Version get version =>
      _version ??= _parseVersion(Browser.navigator ?? TestNavigator());

  static List<Browser> _knownBrowsers = [
    internetExplorer,
    firefox,
    safari,
    wkWebView,
    chrome,
  ];

  bool get isChrome => this == chrome;
  bool get isFirefox => this == firefox;
  bool get isSafari => this == safari;
  bool get isInternetExplorer => this == internetExplorer;
  bool get isWKWebView => this == wkWebView;
}

Browser chrome = _Chrome();
Browser firefox = _Firefox();
Browser safari = _Safari();
Browser internetExplorer = _InternetExplorer();
Browser wkWebView = _WKWebView();

class _Chrome extends Browser {
  _Chrome() : super('Chrome', _isChrome, _getVersion);

  static bool _isChrome(NavigatorProvider navigator) =>
      navigator.vendor.contains('Google');

  static Version _getVersion(NavigatorProvider navigator) {
    Match? match = RegExp(r"Chrome/(\d+)\.(\d+)\.(\d+)\.(\d+)\s")
        .firstMatch(navigator.appVersion);
    if (match != null) {
      var major = int.parse(match.group(1)!);
      var minor = int.parse(match.group(2)!);
      var patch = int.parse(match.group(3)!);
      var build = match.group(4);
      return Version(major, minor, patch, build: build);
    } else {
      return Version(0, 0, 0);
    }
  }
}

class _Firefox extends Browser {
  _Firefox() : super('Firefox', _isFirefox, _getVersion);

  static bool _isFirefox(NavigatorProvider navigator) {
    return navigator.userAgent.contains('Firefox');
  }

  static Version _getVersion(NavigatorProvider navigator) {
    Match match = RegExp(r'rv:(\d+)\.(\d+)\)').firstMatch(navigator.userAgent)!;
    var major = int.parse(match.group(1)!);
    var minor = int.parse(match.group(2)!);
    return Version(major, minor, 0);
  }
}

class _Safari extends Browser {
  _Safari() : super('Safari', _isSafari, _getVersion);

  static bool _isSafari(NavigatorProvider navigator) {
    // An web view running in an iOS app does not have a 'Version/X.X.X' string in the appVersion
    var vendor = navigator.vendor;
    return vendor.contains('Apple') && navigator.appVersion.contains('Version');
  }

  static Version _getVersion(NavigatorProvider navigator) {
    Match match = RegExp(r'Version/(\d+)(\.(\d+))?(\.(\d+))?')
        .firstMatch(navigator.appVersion)!;
    var major = int.parse(match.group(1)!);
    var minor = int.parse(match.group(3) ?? '0');
    var patch = int.parse(match.group(5) ?? '0');

    return Version(major, minor, patch);
  }
}

class _WKWebView extends Browser {
  _WKWebView() : super('WKWebView', _isWKWebView, _getVersion);

  static bool _isWKWebView(NavigatorProvider navigator) {
    // An web view running in an iOS app does not have a 'Version/X.X.X' string in the appVersion
    var vendor = navigator.vendor;
    return vendor.contains('Apple') &&
        !navigator.appVersion.contains('Version');
  }

  static Version _getVersion(NavigatorProvider navigator) {
    Match match = RegExp(r'AppleWebKit/(\d+)\.(\d+)\.(\d+)')
        .firstMatch(navigator.appVersion)!;
    var major = int.parse(match.group(1)!);
    var minor = int.parse(match.group(2)!);
    var patch = int.parse(match.group(3)!);
    return Version(major, minor, patch);
  }
}

class _InternetExplorer extends Browser {
  _InternetExplorer()
      : super('Internet Explorer', _isInternetExplorer, _getVersion,
            className: 'ie');

  static bool _isInternetExplorer(NavigatorProvider navigator) {
    return navigator.appName.contains('Microsoft') ||
        navigator.appVersion.contains('Trident') ||
        navigator.appVersion.contains('Edge');
  }

  static Version _getVersion(NavigatorProvider navigator) {
    Match? match =
        RegExp(r'MSIE (\d+)\.(\d+);').firstMatch(navigator.appVersion);
    if (match != null) {
      var major = int.parse(match.group(1)!);
      var minor = int.parse(match.group(2)!);
      return Version(major, minor, 0);
    }

    match = RegExp(r'rv[: ](\d+)\.(\d+)').firstMatch(navigator.appVersion);
    if (match != null) {
      var major = int.parse(match.group(1)!);
      var minor = int.parse(match.group(2)!);
      return Version(major, minor, 0);
    }

    match = RegExp(r'Edge/(\d+)\.(\d+)$').firstMatch(navigator.appVersion);
    if (match != null) {
      var major = int.parse(match.group(1)!);
      var minor = int.parse(match.group(2)!);
      return Version(major, minor, 0);
    }

    return Version(0, 0, 0);
  }
}
