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
import 'dart:html';

import 'package:platform_detect/platform_detect.dart' show browser;

/// The [Feature]s that `decorateRootNodeWithPlatformClasses` will produce CSS classes for no matter what.
final List<Feature> defaultFeatureCssClassDecorators = [
  Feature.touchEvents,
  Feature.msTouchEvents,
];

/// A class of constants that represent the features that a browser supports.
class Feature {
  /// The string representation of the feature that can be used via `decorateRootNodeWithPlatformClasses`
  /// as a CSS class on the `<html>` element for conditional CSS styling.
  final String name;

  /// Whether the feature is supported by the current browser.
  final bool isSupported;

  @override
  bool operator ==(dynamic other) => other is Feature && other.name == name;

  @override
  int get hashCode => name.hashCode;

  Feature(this.name, this.isSupported);

  /// Whether the browser supports [TouchEvent]s.
  ///
  /// Related: [msTouchEvents]
  ///
  /// As of Dart 2.5.0, [TouchEvent.supported] is always true on Chrome 70+,
  /// even on non-touch devices.
  ///
  /// This feature checks whether maxTouchPoints is greater than 0
  /// (if it exists, falling back to TouchEvent.supported),
  /// which is the recommended way to check for touch screens.
  ///
  /// See:
  /// - https://www.chromestatus.com/feature/4764225348042752
  /// - https://github.com/dart-lang/sdk/commit/3a7101e16b48b67fc0a832444b06e79a169bce86
  static final Feature touchEvents = Feature(
      'touch',
      window.navigator.maxTouchPoints != null
          ? window.navigator.maxTouchPoints! > 0
          : TouchEvent.supported);

  /// Whether the internet explorer browser supports touch events.
  ///
  /// Related: [touchEvents]
  static final Feature msTouchEvents = Feature('mstouch',
      browser.isInternetExplorer && (window.navigator.maxTouchPoints ?? 0) > 1);
}
