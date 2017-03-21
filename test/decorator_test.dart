@TestOn('browser')
import 'dart:html';

import 'package:test/test.dart';

import 'package:platform_detect/platform_detect.dart';
import 'package:platform_detect/src/decorator.dart';
import 'package:platform_detect/src/support.dart';

void main() {
  group('root node CSS class injection', () {
    Element fakeRootNode;
    List calls;
    CssClassSet fakeRootNodeClasses;
    Feature consumerFeature;

    void callback() {
      calls.add('callback');
    }

    setUp(() {
      calls = [];
      fakeRootNode = new DivElement();
      consumerFeature =
          new Feature('canvas', new CanvasElement().context2D != null);
      decorateRootNodeWithPlatformClasses(
          features: [consumerFeature],
          rootNode: fakeRootNode,
          callback: callback);
      fakeRootNodeClasses = fakeRootNode.classes;
    });

    tearDown(() {
      fakeRootNode = null;
      consumerFeature = null;
      fakeRootNodeClasses = null;
    });

    test('should only happen once', () {
      expect(calls, orderedEquals(['callback']));

      decorateRootNodeWithPlatformClasses(
          rootNode: fakeRootNode, callback: callback);

      expect(calls, orderedEquals(['callback']));
    });

    test('should identify the operating system', () {
      expect(fakeRootNodeClasses,
          contains('os-${nameToClassName(operatingSystem.name)}'));
    });

    group('should identify the browser', () {
      test('', () {
        expect(fakeRootNodeClasses,
            contains('ua-${nameToClassName(browser.name)}'));
      });

      test('major version', () {
        expect(
            fakeRootNodeClasses,
            contains(
                'ua-${nameToClassName(browser.name)}${browser.version.major}'));
      });

      test('major +$maxVersionRange version range', () {
        for (var i = minVersionRange;
            i < minVersionRange + maxVersionRange;
            i++) {
          expect(fakeRootNodeClasses,
              contains('ua-lt-${nameToClassName(browser.name)}$i'));
        }
      });
    });

    group('should identify feature support:', () {
      // TODO: Set up saucelabs and run these tests on actual browsers on which we can assert whether
      // our baked-in feature detection is accurate
      test('default features', () {
        for (var i = 0; i < defaultFeatureCssClassDecorators.length; i++) {
          expect(
              fakeRootNodeClasses,
              contains(matches(new RegExp(
                  '(no-)*${defaultFeatureCssClassDecorators[i].name}'))));
        }
      });

      test('custom feature provided by the consumer', () {
        expect(fakeRootNodeClasses,
            contains(matches(new RegExp('(no-)*${consumerFeature.name}'))));
      });
    });
  });
}
