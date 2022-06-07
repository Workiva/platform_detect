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
        (system) => navigator != null && system._matchesNavigator(navigator!),
        orElse: () => UnknownOS);
  }

  static OperatingSystem UnknownOS = OperatingSystem('Unknown', (_) => false);

  final String name;
  final bool Function(NavigatorProvider) _matchesNavigator;

  OperatingSystem(this.name, this._matchesNavigator);

  static List<OperatingSystem> _knownSystems = [
    chrome,
    mac,
    windows,
    linux,
    unix
  ];

  bool get isLinux => this == linux;
  bool get isMac => this == mac;
  bool get isUnix => this == unix;
  bool get isWindows => this == windows;
  bool get isChromeOS => this == chrome;
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
