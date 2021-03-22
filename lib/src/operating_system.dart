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
  static NavigatorProvider? navigator;

  static OperatingSystem getCurrentOperatingSystem() {
    return _knownSystems.firstWhere(
      (system) {
        final matcher = system._matchesNavigator;
        if (matcher == null) return false;
        return matcher(navigator);
      },
      orElse: () => UnknownOS,
    );
  }

  static OperatingSystem UnknownOS = OperatingSystem('Unknown', null);

  final String name;
  final bool Function(NavigatorProvider? navigator)? _matchesNavigator;

  OperatingSystem(
      this.name, bool Function(NavigatorProvider? navigator)? matchesNavigator)
      : _matchesNavigator = matchesNavigator;

  static List<OperatingSystem> _knownSystems = [mac, windows, linux, unix];

  get isLinux => this == linux;
  get isMac => this == mac;
  get isUnix => this == unix;
  get isWindows => this == windows;
}

OperatingSystem linux =
    OperatingSystem('Linux', (NavigatorProvider? navigator) {
  if (navigator == null) return false;
  return navigator.appVersion.contains('Linux');
});

OperatingSystem mac = OperatingSystem('Mac', (NavigatorProvider? navigator) {
  if (navigator == null) return false;
  return navigator.appVersion.contains('Mac');
});

OperatingSystem unix = OperatingSystem('Unix', (NavigatorProvider? navigator) {
  if (navigator == null) return false;
  return navigator.appVersion.contains('X11');
});

OperatingSystem windows =
    OperatingSystem('Windows', (NavigatorProvider? navigator) {
  if (navigator == null) return false;
  return navigator.appVersion.contains('Win');
});
