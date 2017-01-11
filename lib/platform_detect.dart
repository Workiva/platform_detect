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

/// Enables detection of browser type and version and operating system
///
/// Use browser.isChrome or operatingSystem.isMac
library platform_detect;

import 'dart:html';

import 'package:platform_detect/src/browser.dart';
import 'package:platform_detect/src/navigator.dart';
import 'package:platform_detect/src/operating_system.dart';

export 'src/browser.dart';
export 'src/operating_system.dart';

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
