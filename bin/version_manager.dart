import 'package:args/args.dart';
import 'package:version_manager/version_manager.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('increment', abbr: 'i', help: 'Specify which part of the version to increment (major, minor, patch, build)')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Displays this help information');

  var argResults = parser.parse(arguments);

  if (argResults['help'] as bool || !argResults.wasParsed('increment')) {
    print('Usage: version_manager --increment [major|minor|patch|build]');
    print(parser.usage);
    return;
  }

  final versionManager = VersionManager();
  final partToIncrement = argResults['increment'] as String?;

  if (partToIncrement != null && ['major', 'minor', 'patch', 'build'].contains(partToIncrement)) {
    versionManager.updateVersion(partToIncrement);
  } else {
    print('Invalid option for --increment. Use: major, minor, patch, or build.');
  }
}