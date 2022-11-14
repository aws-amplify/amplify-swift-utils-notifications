Pod::Spec.new do |spec|

  spec.name          = "AmplifyUtilsNotifications"
  spec.version       = "0.0.2"
  spec.summary       = "AWS Amplify Swift Utilities for Notifications."

  spec.description   = "<<-DESC
  Amplify Swift Utilities for Notifications provides helpful functionality for working with push notifications on iOS and macOS.
  Although it was developed for use with AWS Amplify, it can also be used indepdendently.

  The following features are provided:
    * Service extension to support fetching and attaching remote media to notifications
    * Convenience methods to support requesting notification permissions and registering with APNs
  DESC"

  spec.homepage      = "https://github.com/aws-amplify/amplify-swift-utils-notifications"
  spec.license       = "Apache License, Version 2.0"
  spec.author        = { "Amazon Web Services" => "amazonwebservices" }

  spec.ios.deployment_target = "13.0"
  spec.osx.deployment_target = "10.15"
  spec.swift_version = "5.6"

  spec.source        = { :git => "https://github.com/aws-amplify/amplify-swift-utils-notifications.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/AmplifyUtilsNotifications/**/*.swift"

  # spec.framework     = "UserNotifications"

end
