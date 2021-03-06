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
import 'package:platform_detect/src/navigator.dart';

/// Matches an operating system name with how it is represented in window.navigator
class OperatingSystem {
  // nullable for testability
  static NavigatorProvider? navigator;

  static OperatingSystem getCurrentOperatingSystem() {
    return _knownSystems.firstWhere(
        (system) => system._matchesNavigator(navigator),
        orElse: () => UnknownOS);
  }

  static OperatingSystem UnknownOS = OperatingSystem('Unknown', (n) => false);

  final String name;
  final Function _matchesNavigator;

  OperatingSystem(
      this.name, bool this._matchesNavigator(NavigatorProvider navigator));

  static List<OperatingSystem> _knownSystems = [
    chrome,
    mac,
    windows,
    linux,
    unix
  ];

  get isLinux => this == linux;
  get isMac => this == mac;
  get isUnix => this == unix;
  get isWindows => this == windows;
  get isChromeOS => this == chrome;
}

OperatingSystem linux = OperatingSystem('Linux', (NavigatorProvider navigator) {
  return navigator.appVersion.contains('Linux');
});

OperatingSystem mac = OperatingSystem('Mac', (NavigatorProvider navigator) {
  return navigator.appVersion.contains('Mac');
});

OperatingSystem unix = OperatingSystem('Unix', (NavigatorProvider navigator) {
  return navigator.appVersion.contains('X11');
});

OperatingSystem windows =
    OperatingSystem('Windows', (NavigatorProvider navigator) {
  return navigator.appVersion.contains('Win');
});

OperatingSystem chrome =
    OperatingSystem('ChromeOS', (NavigatorProvider navigator) {
  return navigator.appVersion.contains('CrOS');
});
