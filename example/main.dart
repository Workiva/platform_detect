// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:web/web.dart';
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

void main() {
  decorateRootNodeWithPlatformClasses();

  _parseCurrentBrowser();
  _parseDecoratorValues();
  HTMLButtonElement evaluate =
      querySelector('#evaluate-test') as HTMLButtonElement;
  evaluate.onClick.listen((_) => _parseTestValues());
}

void _parseCurrentBrowser() {
  document.querySelector('#$currentBrowserId')!.text = browser.name;
  document.querySelector('#$currentBrowserVersionId')!.text =
      browser.version.toString();
  document.querySelector('#$currentOsId')!.text = operatingSystem.name;
  document.querySelector('#$currentVendorId')!.text = window.navigator.vendor;
  document.querySelector('#$currentAppVersionId')!.text =
      window.navigator.appVersion;
  document.querySelector('#$currentAppNameId')!.text = window.navigator.appName;
  document.querySelector('#$currentUserAgentId')!.text =
      window.navigator.userAgent;

  HTMLInputElement isChrome =
      document.querySelector('#$isChromeCheckboxId') as HTMLInputElement;
  isChrome.checked = browser.isChrome;

  HTMLInputElement isFirefox =
      document.querySelector('#$isFirefoxCheckboxId') as HTMLInputElement;
  isFirefox.checked = browser.isFirefox;

  HTMLInputElement isSafari =
      document.querySelector('#$isSafariCheckboxId') as HTMLInputElement;
  isSafari.checked = browser.isSafari;

  HTMLInputElement isInternetExplorer =
      document.querySelector('#$isIeCheckboxId') as HTMLInputElement;
  isInternetExplorer.checked = browser.isInternetExplorer;
}

void _parseTestValues() {
  HTMLInputElement testVendorInput =
      querySelector('#$testVendorId') as HTMLInputElement;
  HTMLInputElement testAppVersionInput =
      querySelector('#$testAppVersionId') as HTMLInputElement;
  HTMLInputElement testAppNameInput =
      querySelector('#$testAppNameId') as HTMLInputElement;
  HTMLInputElement testUserAgentInput =
      querySelector('#$testUserAgentId') as HTMLInputElement;

  var navigator = TestNavigator();
  navigator.vendor = testVendorInput.value!.trim();
  navigator.appVersion = testAppVersionInput.value!.trim();
  navigator.appName = testAppNameInput.value!.trim();
  navigator.userAgent = testUserAgentInput.value!.trim();
  Browser.navigator = navigator;
  OperatingSystem.navigator = navigator;

  var browser = Browser.getCurrentBrowser();
  var operatingSystem = OperatingSystem.getCurrentOperatingSystem();
  querySelector('#$testBrowserId-name')!.text = browser.name;
  querySelector('#$testBrowserId-version')!.text = browser.version.toString();
  querySelector('#$testOsId-name')!.text = operatingSystem.name;
}

void _parseDecoratorValues() {
  List<String> htmlElementClasses =
      domTokenListToListString(document.documentElement!.classList);

  String osDecorators = htmlElementClasses
      .toList()
      .where((classStr) => classStr.contains(osClassPrefix))
      .join(' ');

  String browserDecorators = htmlElementClasses
      .toList()
      .where((classStr) => classStr.contains(browserClassPrefix))
      .join(' ');

  String featureDecorators =
      getFeatureSupportClasses(defaultFeatureCssClassDecorators);

  querySelector('#$currentOsId-decorators')!.text = osDecorators;
  querySelector('#$currentBrowserId-decorators')!.text = browserDecorators;
  querySelector('#current-feature-decorators')!.text = featureDecorators;
}
