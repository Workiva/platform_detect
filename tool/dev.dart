import 'package:dart_dev/dart_dev.dart' show dev, config;

main(List<String> args) async {
  config.analyze.entryPoints = [
    'example/main.dart',
    'lib/platform_detect.dart',
    'lib/test_utils.dart',
    'test/browser_test.dart',
    'test/decorator_test.dart',
    'test/operating_system_test.dart',
    'test/test_utils_test.dart',
    'tool/dev.dart',
  ];

  config.format
    ..directories = [
      'example/',
      'lib/',
      'test/',
      'tool/',
    ];

  config.test..platforms = ['content-shell', 'vm'];

  await dev(args);
}
