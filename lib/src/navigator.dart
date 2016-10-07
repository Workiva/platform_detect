library platform_detect.navigator;

/// Abstraction over window.navigator so we can run tests in the VM
abstract class NavigatorProvider {
  String get vendor;
  String get appVersion;
  String get appName;
  String get userAgent;
}

/// Simple implementation that enables ease of unit testing
class TestNavigator implements NavigatorProvider {
  String vendor = '';
  String appVersion = '';
  String appName = '';
  String userAgent = '';
}
