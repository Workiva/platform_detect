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

  static List<OperatingSystem> _knownSystems = [mac, windows, linux, unix];

  get isLinux => this == linux;
  get isMac => this == mac;
  get isUnix => this == unix;
  get isWindows => this == windows;
}

OperatingSystem linux =
    new OperatingSystem('Linux', (NavigatorProvider navigator) {
  return navigator.appVersion.contains('Linux');
});

OperatingSystem mac = new OperatingSystem('Mac', (NavigatorProvider navigator) {
  return navigator.appVersion.contains('Mac');
});

OperatingSystem unix =
    new OperatingSystem('Unix', (NavigatorProvider navigator) {
  return navigator.appVersion.contains('X11');
});

OperatingSystem windows =
    new OperatingSystem('Windows', (NavigatorProvider navigator) {
  return navigator.appVersion.contains('Win');
});
