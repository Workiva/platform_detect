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
