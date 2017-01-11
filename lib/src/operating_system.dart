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

library platform_detect.operating_system;

import 'package:platform_detect/src/navigator.dart';

/// Matches an operating system name with how it is represented in window.navigator
class OperatingSystem {
  static NavigatorProvider navigator;

  static OperatingSystem getCurrentOperatingSystem() {
    return _knownSystems.firstWhere(
        (system) => system._matchesNavigator(navigator),
        orElse: () => UnknownOS);
  }

  static OperatingSystem UnknownOS = new OperatingSystem('Unknown', null);

  final String name;
  final Function _matchesNavigator;

  OperatingSystem(this.name, bool matchesNavigator(NavigatorProvider navigator))
      : this._matchesNavigator = matchesNavigator;

  static List<OperatingSystem> _knownSystems = [_mac, _windows, _unix, _linux];

  get isMac => this == _mac;
  get isWindows => this == _windows;
  get isUnix => this == _unix;
  get isLinux => this == _linux;

  static OperatingSystem _mac =
      new OperatingSystem('Mac', (NavigatorProvider navigator) {
    return navigator.appVersion.contains('Mac');
  });

  static OperatingSystem _windows =
      new OperatingSystem('Windows', (NavigatorProvider navigator) {
    return navigator.appVersion.contains('Win');
  });

  static OperatingSystem _unix =
      new OperatingSystem('Unix', (NavigatorProvider navigator) {
    return navigator.appVersion.contains('X11');
  });

  static OperatingSystem _linux =
      new OperatingSystem('Linux', (NavigatorProvider navigator) {
    return navigator.appVersion.contains('Linux');
  });
}
