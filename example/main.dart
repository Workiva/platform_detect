import 'dart:html';
import 'package:platform_detect/platform_detect.dart';
import 'package:platform_detect/src/decorator.dart';

// HTML Element IDs
const String browserIdSuffix = 'browser';
const String browserVersionIdSuffix = 'version';
const String osIdSuffix = 'os';
const String vendorIdSuffix = 'vendor';
const String appVersionIdSuffix = 'appVersion';
const String appNameIdSuffix = 'appName';
const String userAgentIdSuffix = 'userAgent';

const String currentBrowserId = 'current-$browserIdSuffix';
const String currentBrowserVersionId = 'current-$browserVersionIdSuffix';
const String currentOsId = 'current-$osIdSuffix';
const String currentVendorId = 'current-$vendorIdSuffix';
const String currentAppVersionId = 'current-$appVersionIdSuffix';
const String currentAppNameId = 'current-$appNameIdSuffix';
const String currentUserAgentId = 'current-$userAgentIdSuffix';

const String testBrowserId = 'test-$browserIdSuffix';
const String testVendorId = 'test-$vendorIdSuffix';
const String testOsId = 'test-$osIdSuffix';
const String testAppVersionId = 'test-$appVersionIdSuffix';
const String testAppNameId = 'test-$appNameIdSuffix';
const String testUserAgentId = 'test-$userAgentIdSuffix';

const String isChromeCheckboxId = 'current-is-chrome';
const String isFirefoxCheckboxId = 'current-is-firefox';
const String isSafariCheckboxId = 'current-is-safari';
const String isIeCheckboxId = 'current-is-ie';

main() {
  decorateRootNodeWithPlatformClasses();

  _parseCurrentBrowser();
  _parseDecoratorValues();
  ButtonElement evaluate = querySelector('#evaluate-test');
  evaluate.onClick.listen((_) => _parseTestValues());
}

void _parseCurrentBrowser() {
  document.querySelector('#$currentBrowserId').text = browser.name;
  document.querySelector('#$currentBrowserVersionId').text =
      browser.version.toString();
  document.querySelector('#$currentOsId').text = operatingSystem.name;
  document.querySelector('#$currentVendorId').text = window.navigator.vendor;
  document.querySelector('#$currentAppVersionId').text =
      window.navigator.appVersion;
  document.querySelector('#$currentAppNameId').text = window.navigator.appName;
  document.querySelector('#$currentUserAgentId').text =
      window.navigator.userAgent;

  CheckboxInputElement isChrome =
      document.querySelector('#$isChromeCheckboxId');
  isChrome.checked = browser.isChrome;

  CheckboxInputElement isFirefox =
      document.querySelector('#$isFirefoxCheckboxId');
  isFirefox.checked = browser.isFirefox;

  CheckboxInputElement isSafari =
      document.querySelector('#$isSafariCheckboxId');
  isSafari.checked = browser.isSafari;

  CheckboxInputElement isInternetExplorer =
      document.querySelector('#$isIeCheckboxId');
  isInternetExplorer.checked = browser.isInternetExplorer;
}

void _parseTestValues() {
  InputElement testVendorInput = querySelector('#$testVendorId');
  InputElement testAppVersionInput = querySelector('#$testAppVersionId');
  InputElement testAppNameInput = querySelector('#$testAppNameId');
  InputElement testUserAgentInput = querySelector('#$testUserAgentId');

  var navigator = new TestNavigator();
  navigator.vendor = testVendorInput.value.trim();
  navigator.appVersion = testAppVersionInput.value.trim();
  navigator.appName = testAppNameInput.value.trim();
  navigator.userAgent = testUserAgentInput.value.trim();
  Browser.navigator = navigator;
  OperatingSystem.navigator = navigator;

  var browser = Browser.getCurrentBrowser();
  var operatingSystem = OperatingSystem.getCurrentOperatingSystem();
  querySelector('#$testBrowserId-name').text = browser.name;
  querySelector('#$testBrowserId-version').text = browser.version.toString();
  querySelector('#$testOsId-name').text = operatingSystem.name;
}

void _parseDecoratorValues() {
  CssClassSet htmlElementClasses = document.documentElement.classes;

  String osDecorators = htmlElementClasses
      .toList()
      .where((classStr) => classStr.indexOf(osClassPrefix) > -1)
      .join(' ');

  String browserDecorators = htmlElementClasses
      .toList()
      .where((classStr) => classStr.indexOf(browserClassPrefix) > -1)
      .join(' ');

  String featureDecorators =
      getFeatureSupportClasses(defaultFeatureCssClassDecorators);

  querySelector('#$currentOsId-decorators').text = osDecorators;
  querySelector('#$currentBrowserId-decorators').text = browserDecorators;
  querySelector('#current-feature-decorators').text = featureDecorators;
}
