# Version Manager

`version_manager` is a Dart package that automates version management for Flutter and Dart projects. It allows you to increment specific parts of the version (major, minor, patch, build) in the `pubspec.yaml` file directly from the command line.

## Features

- Automatically increment **major**, **minor**, **patch**, or **build** versions in your `pubspec.yaml` file.
- Easy-to-use command-line interface.
- Specify the path to any `pubspec.yaml` file.
- Seamlessly integrates into your CI/CD pipeline for automated version management.

## Installation
To install the `version_manager` package globally, run:

```bash
dart pub global activate version_manager
```

## Usage
Once installed globally, you can increment the version by running:

```bash
dart run version_manager --increment <part>
```

Where `<part>` can be:

- major - Increments the major version (e.g., 1.0.0 -> 2.0.0)
- minor - Increments the minor version (e.g., 1.2.0 -> 1.3.0)
- patch - Increments the patch version (e.g., 1.2.3 -> 1.2.4)
- build - Increments the build number (e.g., 1.2.3+4 -> 1.2.3+5)

## Examples
1. Increment the patch version in the current directory's `pubspec.yaml`:
   
```bash
dart run version_manager --increment patch
```

## Help
To see all available options:

```bash
dart run version_manager --help
```

## Contributing
Contributions are welcome! If you have suggestions for improvements or new features, please feel free to create a pull request or open an issue.

## License
This project is licensed under the MIT License.

