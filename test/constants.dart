import 'package:platform_detect/src/navigator.dart';

const String chromeUserAgentTestString =
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36';
const String chromeAppVersionTestString =
    '5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36';
const String chromeAppNameTestString = 'Netscape';
const String chromeVendorTestString = 'Google Inc.';

const String chromelessUserAgentTestString = 'Chromeless 1.0.1';
const String chromelessAppVersionTestString = 'Chromeless 1.0.1';

const String firefoxUserAgentTestString =
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:48.0) Gecko/20100101 Firefox/48.0';
const String firefoxAppVersionTestString = '5.0 (Macintosh)';
const String firefoxAppNameTestString = 'Netscape';
const String firefoxVendorTestString = 'Mozilla';

const String ieUserAgentTestString =
    'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; rv:11.0) like Gecko';
const String ieAppVersionTestString =
    '5.0 (Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; rv:11.0) like Gecko';
const String ieAppNameTestString = 'Netscape';
const String ieVendorTestString = 'Microsoft';

const String ieEdgeUserAgentTestString =
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.10136';
const String ieEdgeAppVersionTestString =
    '5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.10136';

const String safariUserAgentTestString =
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/9.1.3 Safari/601.7.8';
const String safariAppVersionTestString =
    '5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/9.1.3 Safari/601.7.8';
const String safariUserAgentWithoutPatchTestString =
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/10.1 Safari/601.7.8';
const String safariAppVersionWithoutPatchTestString =
    '5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/10.1 Safari/601.7.8';
const String safariUserAgentWithoutMinorTestString =
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/11 Safari/601.7.8';
const String safariAppVersionWithoutMinorTestString =
    '5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/11 Safari/601.7.8';
const String safariAppNameTestString = 'Netscape';
const String safariVendorTestString = 'Apple Computer, Inc.';

const String wkWebViewUserAgentTestString =
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Version/9.1.3 Safari/601.7.8';
const String wkWebViewAppVersionTestString =
    '5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/601.7.8 (KHTML, like Gecko) Safari/601.7.8';
const String wkWebViewAppNameTestString = 'Netscape';
const String wkWebViewVendorTestString = 'Apple Computer, Inc.';

TestNavigator testChrome({
  String userAgent = chromeUserAgentTestString,
  String appVersion = chromeAppVersionTestString,
  String appName = chromeAppNameTestString,
  String vendor = chromeVendorTestString,
}) {
  return TestNavigator()
    ..userAgent = userAgent
    ..appVersion = appVersion
    ..appName = appName
    ..vendor = vendor;
}

TestNavigator testChromeless({
  String userAgent = chromelessUserAgentTestString,
  String appVersion = chromelessAppVersionTestString,
  String appName = chromeAppNameTestString,
  String vendor = chromeVendorTestString,
}) {
  return TestNavigator()
    ..userAgent = userAgent
    ..appVersion = appVersion
    ..appName = appName
    ..vendor = vendor;
}

TestNavigator testFirefox({
  String userAgent = firefoxUserAgentTestString,
  String appVersion = firefoxAppVersionTestString,
  String appName = firefoxAppNameTestString,
  String vendor = firefoxVendorTestString,
}) {
  return TestNavigator()
    ..userAgent = userAgent
    ..appVersion = appVersion
    ..appName = appName
    ..vendor = vendor;
}

TestNavigator testInternetExplorer({
  String userAgent = ieUserAgentTestString,
  String appVersion = ieAppVersionTestString,
  String appName = ieAppNameTestString,
  String vendor = ieVendorTestString,
}) {
  return TestNavigator()
    ..userAgent = userAgent
    ..appVersion = appVersion
    ..appName = appName
    ..vendor = vendor;
}

TestNavigator testInternetExplorerEdge() => testInternetExplorer(
      userAgent: ieEdgeUserAgentTestString,
      appVersion: ieEdgeAppVersionTestString,
    );

TestNavigator testSafari({
  String userAgent = safariUserAgentTestString,
  String appVersion = safariAppVersionTestString,
  String appName = safariAppNameTestString,
  String vendor = safariVendorTestString,
}) {
  return TestNavigator()
    ..userAgent = userAgent
    ..appVersion = appVersion
    ..appName = appName
    ..vendor = vendor;
}

TestNavigator testWkWebView({
  String userAgent = wkWebViewUserAgentTestString,
  String appVersion = wkWebViewAppVersionTestString,
  String appName = wkWebViewAppNameTestString,
  String vendor = wkWebViewVendorTestString,
}) {
  return TestNavigator()
    ..userAgent = userAgent
    ..appVersion = appVersion
    ..appName = appName
    ..vendor = vendor;
}
