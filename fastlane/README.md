fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios tests

```sh
[bundle exec] fastlane ios tests
```

Run all the tests on iOS

### ios integration_tests

```sh
[bundle exec] fastlane ios integration_tests
```

Run integration test on iOS simulator

### ios release

```sh
[bundle exec] fastlane ios release
```

Publish to Cocoapods whenever a new version tag is created

### ios publish_doc

```sh
[bundle exec] fastlane ios publish_doc
```

Generate and publish documentaion for new version

----


## Mac

### mac tests

```sh
[bundle exec] fastlane mac tests
```

Run all the tests on macOS

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
