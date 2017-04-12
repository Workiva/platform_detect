[![codecov](https://codecov.io/gh/Workiva/platform_detect/branch/master/graph/badge.svg)](https://codecov.io/gh/Workiva/platform_detect)
[![documentation](https://img.shields.io/badge/Documentation-platform__detect-blue.svg)](https://www.dartdocs.org/documentation/platform_detect/latest)

# platform_detect

A library for detecting browser and platform type and version.

## Usage

A simple usage example:

```dart
import 'package:platform_detect/platform_detect.dart';

main() {
  if (browser.isChrome) {
	print('thank you for being a friend');
  }

  if (operatingSystem.isMac) {
	print('');
  }
}
```

## Decorating the `<html>` element with CSS classes

This library can also be used to place CSS classes on the `<html>` element based on the
operating system, browser, or a specific supported feature.

Add the `decorator.dart` import as shown in the example below, and call `decorateRootNodeWithPlatformClasses`
within `main` in your application.

```dart
import 'package:platform_detect/platform_detect.dart';
import 'package:platform_detect/decorator.dart';

main() {
  decorateRootNodeWithPlatformClasses();
}
```

The `<html>` node of your application will now look like something like this:

```html
<html lang="en" class="ua-chrome ua-chrome45 ua-lt-chrome46 ua-lt-chrome47 os-mac no-touch no-mstouch">
  <!-- ... -->
</html>
```

### Feature detection

By default, the only browser feature that the library detects for you is touch / mstouch.

You can extend this functionality to bake in a Modernizr-_esque_ implementation by creating your
own `Feature` instances, and passing a list of them as the `features` argument to
`decorateRootNodeWithPlatformClasses`:

```dart
import 'package:platform_detect/platform_detect.dart';
import 'package:platform_detect/decorator.dart';

// For instance, if you need to detect whether a browser supports H5 canvas stuff...
var canvasFeature = new Feature('canvas', new CanvasElement().context2D != null);

main() {
  // Decorate HTML element
  decorateRootNodeWithPlatformClasses(features: [canvasFeature]);

  // Or use the `isSupported` field somewhere else in your app...
  if (canvasFeature.isSupported) {
    // Do something
  } else {
    // Fall back / warn / etc...
  }
}
```

The `<html>` node of your application will now look like something like this
for browsers that support canvas:

```html
<html lang="en" class="canvas ...">
  <!-- ... -->
</html>
```

and something like this for browsers that don't support canvas:

```html
<html lang="en" class="no-canvas ...">
  <!-- ... -->
</html>
```
