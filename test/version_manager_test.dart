import 'dart:async';
import 'dart:io';
import 'package:test/test.dart';
import 'package:version_manager/version_manager.dart';

void main() {
  group('VersionManager', () {
    late File pubspecFile;
    late VersionManager versionManager;

    setUp(() {
      // Create a temporary pubspec.yaml file for testing
      pubspecFile = File('./test/pubspec.yaml');
      pubspecFile.writeAsStringSync('''
name: test_app
description: A test app
version: 1.2.3+4
''');

      // Initialize the VersionManager
      versionManager = VersionManager();
    });

    tearDown(() {
      // Clean up by deleting the temporary file
      if (pubspecFile.existsSync()) {
        pubspecFile.deleteSync();
      }
    });

    test('should increment major version', () {
      versionManager.updateVersion('major');
      final content = pubspecFile.readAsStringSync();
      expect(content.contains('version: 2.0.0+0'), isTrue);
    });

    test('should increment minor version', () {
      versionManager.updateVersion('minor');
      final content = pubspecFile.readAsStringSync();
      expect(content.contains('version: 1.3.0+0'), isTrue);
    });

    test('should increment patch version', () {
      versionManager.updateVersion('patch');
      final content = pubspecFile.readAsStringSync();
      expect(content.contains('version: 1.2.4+0'), isTrue);
    });

    test('should increment build version', () {
      versionManager.updateVersion('build');
      final content = pubspecFile.readAsStringSync();
      expect(content.contains('version: 1.2.3+5'), isTrue);
    });

    test('should return error if pubspec.yaml is missing', () {
      // Delete the file to simulate a missing pubspec.yaml
      pubspecFile.deleteSync();

      // Capture the console output
      final log = <String>[];
      final ZoneSpecification spec = ZoneSpecification(print: (self, parent, zone, line) {
        log.add(line);
      });

      Zone.current.fork(specification: spec).run(() {
        versionManager.updateVersion('patch');
      });

      expect(log, contains('Error: pubspec.yaml not found in the current directory.'));
    });

    test('should return error if version format is incorrect', () {
      // Create a pubspec.yaml with an incorrect version format
      pubspecFile.writeAsStringSync('''
name: test_app
description: A test app
version: incorrect_format
''');

      // Capture the console output
      final log = <String>[];
      final ZoneSpecification spec = ZoneSpecification(print: (self, parent, zone, line) {
        log.add(line);
      });

      Zone.current.fork(specification: spec).run(() {
        versionManager.updateVersion('patch');
      });

      expect(log, contains('Error: Version format not recognized in pubspec.yaml.'));
    });
  });
}