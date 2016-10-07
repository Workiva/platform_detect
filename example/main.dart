import 'dart:html';
import 'package:platform_detect/platform_detect.dart';

main() {
  document.querySelector('#current-browser').text = browser.name;
  document.querySelector('#current-vendor').text = window.navigator.vendor;
  document.querySelector('#current-appVersion').text = window.navigator.appVersion;
  document.querySelector('#current-appName').text = window.navigator.appName;
  document.querySelector('#current-userAgent').text = window.navigator.userAgent;

  CheckboxInputElement isChrome = document.querySelector('#current-is-chrome');
  isChrome.checked = browser.isChrome;

  CheckboxInputElement isFirefox = document.querySelector('#current-is-firefox');
  isFirefox.checked = browser.isFirefox;

  CheckboxInputElement isSafari = document.querySelector('#current-is-safari');
  isSafari.checked = browser.isSafari;

  CheckboxInputElement isInternetExplorer = document.querySelector('#current-is-ie');
  isInternetExplorer.checked = browser.isInternetExplorer;

  document.querySelector('#current-version').text = browser.version.toString();

  document.querySelector('#current-os').text = operatingSystem.name;
}
