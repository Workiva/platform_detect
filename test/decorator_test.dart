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

    void callback() {
      calls.add('callback');
    }

    void sharedSetup() {
      calls = [];
      fakeRootNode = new DivElement();
    }

    tearDown(() {
      calls = null;
      fakeRootNode = null;
    });

    group('', () {
      setUp(() {
        sharedSetup();

        decorateRootNodeWithPlatformClasses(
            rootNode: fakeRootNode, callback: callback);
      });

      test('should only happen once', () {
        expect(calls, orderedEquals(['callback']));

        decorateRootNodeWithPlatformClasses(
            rootNode: fakeRootNode, callback: callback);

        expect(calls, orderedEquals(['callback']));
      });

      test('should identify the operating system', () {
        expect(fakeRootNode.classes,
            contains('os-${nameToClassName(operatingSystem.name)}'));
      });

      group('should identify the browser', () {
        test('', () {
          expect(fakeRootNode.classes,
              contains('ua-${nameToClassName(browser.name)}'));
        });

        test('major version', () {
          expect(
              fakeRootNode.classes,
              contains(
                  'ua-${nameToClassName(browser.name)}${browser.version.major}'));
        });

        test('major +$decoratedNextVersionCount version range', () {
          for (var i = nextVersion;
              i < nextVersion + decoratedNextVersionCount;
              i++) {
            expect(fakeRootNode.classes,
                contains('ua-lt-${nameToClassName(browser.name)}$i'));
          }
        });
      });
    });

    // TODO: Set up saucelabs and run these tests on actual browsers on which we can assert whether
    // our baked-in feature detection is accurate
    group('should identify feature support:', () {
      void assertFakeRootNode() {
        if (fakeRootNode == null) {
          throw new AssertionError(
              '`fakeRootNodeClasses` must be set before calling `verifyDistinctFeatureCssClasses`.');
        }
      }

      void verifyDistinctFeatureCssClasses(List<Feature> features) {
        assertFakeRootNode();

        String allCssClasses = fakeRootNode.classes.toString();
        List<String> featureCssClasses =
            getFeatureSupportClasses(features).split(' ');

        for (var i = 0; i < featureCssClasses.length; i++) {
          var affirmativeClassName = features[i].name;
          var negationClassName =
              '$featureSupportNegationClassPrefix-${features[i].name}';

          expect(allCssClasses.allMatches(affirmativeClassName),
              hasLength(lessThan(2)));
          expect(allCssClasses.allMatches(negationClassName),
              hasLength(lessThan(2)));
        }
      }

      void verifyFeatureCssClasses(List<Feature> features) {
        assertFakeRootNode();

        for (var i = 0; i < features.length; i++) {
          // 1. Ensure that its there
          expect(
              fakeRootNode.classes,
              contains(matches(new RegExp(
                  '($featureSupportNegationClassPrefix)*${features[i].name}'))));
        }

        // 2. Ensure that there is only one
        verifyDistinctFeatureCssClasses(features);
      }

      setUp(() {
        sharedSetup();
      });

      test('default features', () {
        decorateRootNodeWithPlatformClasses(
            rootNode: fakeRootNode, callback: callback);

        verifyFeatureCssClasses(defaultFeatureCssClassDecorators);
      });

      group('custom features provided by the consumer', () {
        Feature uniqueConsumerFeature =
            new Feature('canvas', new CanvasElement().context2D != null);
        List<Feature> consumerFeaturesThatContainsNoDefaults = [
          uniqueConsumerFeature
        ];
        List<Feature> consumerFeaturesThatMatchesDefaults =
            new List.from(defaultFeatureCssClassDecorators);
        List<Feature> consumerFeaturesThatContainsDefaults =
            new List.from(defaultFeatureCssClassDecorators)
              ..add(uniqueConsumerFeature);

        group(
            'when none of them are found within `defaultFeatureCssClassDecorators`',
            () {
          test('', () {
            decorateRootNodeWithPlatformClasses(
                features: consumerFeaturesThatContainsNoDefaults,
                rootNode: fakeRootNode,
                callback: callback);

            verifyFeatureCssClasses(
                new List.from(defaultFeatureCssClassDecorators)
                  ..addAll(consumerFeaturesThatContainsNoDefaults));
          });

          test('and `includeDefaults` is set to `false`', () {
            decorateRootNodeWithPlatformClasses(
                features: consumerFeaturesThatContainsDefaults,
                rootNode: fakeRootNode,
                includeDefaults: false,
                callback: callback);

            verifyFeatureCssClasses(consumerFeaturesThatContainsNoDefaults);
          });
        });

        group(
            'when all of them are found within `defaultFeatureCssClassDecorators`',
            () {
          test('', () {
            decorateRootNodeWithPlatformClasses(
                features: consumerFeaturesThatMatchesDefaults,
                rootNode: fakeRootNode,
                callback: callback);

            verifyFeatureCssClasses(consumerFeaturesThatMatchesDefaults);
          });

          test('and `includeDefaults` is set to `false`', () {
            decorateRootNodeWithPlatformClasses(
                features: consumerFeaturesThatMatchesDefaults,
                rootNode: fakeRootNode,
                includeDefaults: false,
                callback: callback);

            verifyFeatureCssClasses(consumerFeaturesThatMatchesDefaults);
          });
        });

        group(
            'when some of them are found within `defaultFeatureCssClassDecorators`',
            () {
          test('', () {
            decorateRootNodeWithPlatformClasses(
                features: consumerFeaturesThatContainsDefaults,
                rootNode: fakeRootNode,
                callback: callback);

            verifyFeatureCssClasses(consumerFeaturesThatContainsDefaults);
          });

          test('and `includeDefaults` is set to `false`', () {
            decorateRootNodeWithPlatformClasses(
                features: consumerFeaturesThatContainsDefaults,
                rootNode: fakeRootNode,
                callback: callback);

            verifyFeatureCssClasses(consumerFeaturesThatContainsDefaults);
          });
        });
      });
    });
  });
}
