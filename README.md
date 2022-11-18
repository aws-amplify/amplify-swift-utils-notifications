## Amplify Swift Utilities for Notifications

Amplify Swift Utilities for Notifications provides helpful functionality for working with push notifications on iOS and macOS.

Although it was developed for use with AWS Amplify, it can also be used independently.


[API Documentation](https://aws-amplify.github.io/amplify-swift-utils-notifications/docs/)


## Features

- Convenience methods to support requesting notification permissions and registering with APNs
- Push Notification Service extension to support fetching and attaching remote media to notifications


## Platform Support
Amplify Swift Utilities for Notifications package supports iOS 13+ and macOS 10.15+.


## License

This package is licensed under the Apache-2.0 License.


## Installation

This package requires Xcode 13.4 or higher to build.


### Swift Package Manager
1. Swift Package Manager is distributed with Xcode. To start adding this package to your iOS project, open your project in Xcode and select **File > Add Packages**.
    - TODO: Add screenshot here

2. Enter the package GitHub repo URL (https://github.com/aws-amplify/amplify-swift-utils-notifications) into the search bar.

3. You'll see the repository rules for which version you want Swift Package Manager to install. Choose **Up to Next Major Version** and enter **1.0.0** as the minimum version for the Dependency Rule, then click **Add Package**.
    - TODO: Add screenshot here

4. Select `AmplifyUtilsNotifications`, then click Add Package.
    - TODO: Add screenshot here

5. In your app code, explicitly import the plugin when you needed.

    ```swift
    import SwiftUI
    import AmplifyUtilsNotifications

    @main
    struct HelloWorldApp: App {
        @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
        var body: some Scene {
            WindowGroup {
                ContentView()
            }
        }
    }

    class AppDelegate: NSObject, UIApplicationDelegate {
        func applicationDidFinishLaunching(_ application: UIApplication) {
            Task {
                let isPushNotificationAllowed = await AmplifyUtilsNotifications.AUNotificationPermissions.allowed
                // ...
            }
        }
    }
    ```

### Cocoapods
1. This package is also available through [CocoaPods](https://cocoapods.org/). If you have not installed CocoaPods, follow the instructions [here](https://guides.cocoapods.org/using/getting-started.html#getting-started).

2. Add the package as a dependency to your Podfile.
    ```ruby
    platform :ios, '13.0'
    use_frameworks!

    target 'HelloWorldApp' do
        pod 'AmplifyUtilsNotifications', '~> 1.0.0'
    end
    ```

3. Then run the following command:
    ```sh
    pod install
    ```

4. Open up *.xcworkspace with Xcode, and you will be able to use the `AmplifyUtilsNotifications` package in your project.

## Reporting Bugs/Feature Requests

[![Open Bugs](https://img.shields.io/github/issues/aws-amplify/amplify-swift-utils-notifications/bug?color=d73a4a&label=bugs)](https://github.com/aws-amplify/amplify-swift-utils-notifications/issues?q=is%3Aissue+is%3Aopen+label%3Abug)
[![Open Questions](https://img.shields.io/github/issues/aws-amplify/amplify-swift-utils-notifications/usage%20question?color=558dfd&label=questions)](https://github.com/aws-amplify/amplify-swift-utils-notifications/issues?q=is%3Aissue+label%3A%22question%22+is%3Aopen+)
[![Feature Requests](https://img.shields.io/github/issues/aws-amplify/amplify-swift-utils-notifications/feature%20request?color=ff9001&label=feature%20requests)](https://github.com/aws-amplify/amplify-swift-utils-notifications/issues?q=is%3Aissue+label%3A%22feature-request%22+is%3Aopen+)
[![Closed Issues](https://img.shields.io/github/issues-closed/aws-amplify/amplify-swift-utils-notifications?color=%2325CC00)](https://github.com/aws-amplify/amplify-swift-utils-notifications/issues?q=is%3Aissue+is%3Aclosed+)

We welcome you to use the GitHub issue tracker to report bugs or suggest features.

When filing an issue, please check [existing open](https://github.com/aws-amplify/amplify-swift-utils-notifications/issues), or [recently closed](https://github.com/aws-amplify/amplify-swift-utils-notifications/issues?utf8=%E2%9C%93&q=is%3Aissue%20is%3Aclosed%20), issues to make sure somebody else hasn't already
reported the issue. Please try to include as much information as you can. Details like these are incredibly useful:

* Expected behavior and observed behavior
* A reproducible test case or series of steps
* The version of our code being used
* Any modifications you've made relevant to the bug
* Anything custom about your environment or deployment
