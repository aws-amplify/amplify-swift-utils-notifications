//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import UserNotifications

#if canImport(AppKit)
import AppKit
typealias Application = NSApplication
#elseif canImport(UIKit)
import UIKit
typealias Application = UIApplication
#endif

@available(iOSApplicationExtension, unavailable)
@available(watchOSApplicationExtension, unavailable)
@available(tvOSApplicationExtension, unavailable)
@available(macCatalystApplicationExtension, unavailable)
@available(OSXApplicationExtension, unavailable)
/// Provides convenience methods for requesting and checking notifications permissions.
public class AUNotificationPermissions {
    
    /// Check if notifications are allowed
    public static var allowed: Bool {
        get async {
            await withCheckedContinuation { continuation in
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    continuation.resume(returning: settings.authorizationStatus == .authorized ? true : false)
                }
            }
        }
    }
    
    /// Request notification permissions
    /// - Parameter options: Requested notification options
    @discardableResult
    public static func request(_ options: UNAuthorizationOptions? = nil) async throws -> Bool {
        let options = options ?? [.badge, .alert, .sound]
        let notificationsAllowed = try await UNUserNotificationCenter.current().requestAuthorization(
            options: options
        )
        
        return notificationsAllowed
    }
    
    /// Register device with APNs
    public static func registerForRemoteNotifications() async {
        await MainActor.run {
            Application.shared.registerForRemoteNotifications()
        }
    }
}
