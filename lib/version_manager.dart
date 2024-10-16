library version_manager;

import 'dart:io';

class VersionManager {
  /// Updates the version in pubspec.yaml based on the specified part to increment.
  /// The [partToIncrement] argument can be 'major', 'minor', 'patch', or 'build'.
  void updateVersion(String partToIncrement) {
    final pubspecFile = File('pubspec.yaml');

    if (!pubspecFile.existsSync()) {
      print('Error: pubspec.yaml not found in the current directory.');
      return;
    }

    String content = pubspecFile.readAsStringSync();
    RegExp versionRegExp = RegExp(r'version: (\d+)\.(\d+)\.(\d+)\+(\d+)');
    final match = versionRegExp.firstMatch(content);

    if (match != null) {
      int major = int.parse(match.group(1)!);
      int minor = int.parse(match.group(2)!);
      int patch = int.parse(match.group(3)!);
      int build = int.parse(match.group(4)!);

      switch (partToIncrement) {
        case 'major':
          major++;
          minor = 0;
          patch = 0;
          break;
        case 'minor':
          minor++;
          patch = 0;
          break;
        case 'patch':
          patch++;
          break;
        case 'build':
          build++;
          break;
        default:
          print('Invalid argument. Use "major", "minor", "patch", or "build".');
          return;
      }

      String newVersion = 'version: $major.$minor.$patch+$build';
      content = content.replaceFirst(versionRegExp, newVersion);
      pubspecFile.writeAsStringSync(content);
      print('Updated version to $newVersion');
    } else {
      print('Error: Version format not recognized in pubspec.yaml.');
    }
  }
}
