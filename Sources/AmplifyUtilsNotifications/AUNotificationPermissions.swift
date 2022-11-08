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
        
        if notificationsAllowed {
            // Register with Apple Push Notification service
            await Application.shared.registerForRemoteNotifications()
        }
        
        return notificationsAllowed
    }
}
