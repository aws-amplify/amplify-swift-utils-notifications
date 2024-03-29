//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

#if !os(tvOS)

import UserNotifications
import os.log

/// Attaches a media (image, sound, or video) item to a remote notification before it’s delivered to the user.
///
/// The media will be downloaded from a URL specified in the incoming notification. The
/// format of the notification payload and name of the field containing the image URL is
/// specified in payloadSchema, which conforms to AUNotificationPayload.
open class AUNotificationService: UNNotificationServiceExtension {
    
    /// Defines the format of incomming notification payloads.
    ///
    /// You can override the default value in the initializer of a child class.
    ///
    /// Default: PinpointNotificationPayload
    public var payloadSchema: AUNotificationPayload.Type = PinpointNotificationPayload.self

    /// Function for retrieve data from remote URL.
    ///
    /// This is for testing only.
    ///
    /// Default: Data.init(contentsOf:options:)
    var loadDataFromURL: (URL) throws -> Data = { try Data(contentsOf: $0) }
    
    /// The content handler for the notification.
    public var contentHandler: ((UNNotificationContent) -> Void)?
    
    /// The content for the notification.
    public var bestAttemptContent: UNMutableNotificationContent?
    
    /// Called when in incomming notification is received. Allows modification of the notification request before delivery.
    /// - Parameters:
    ///   - request: The original notification request. Use this object to get the original content of the notification.
    ///   - contentHandler: The block to execute with the modified content.
    open override func didReceive(
        _ request: UNNotificationRequest,
        withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
    ) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        defer {
            contentHandler(bestAttemptContent ?? request.content)
        }
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content
            guard let mediaAttachment = getMediaAttachment(request) else { return }
            
            os_log(.debug, "created attachment")
            bestAttemptContent.attachments = [mediaAttachment]
        }
    }
    
    /// Called when the system is terminating the extension.
    open override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content,
        // otherwise the original push payload will be used.
        os_log(.debug, "time expired")
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

    private func getMediaAttachment(_ request: UNNotificationRequest) -> UNNotificationAttachment? {
        guard let payloadData = try? payloadSchema.init(decoding: request.content.userInfo),
              let mediaURLString = payloadData.remoteMediaURL,
              let mediaType = mediaURLString.split(separator: ".").last,
              let mediaURL = URL(string: mediaURLString),
              let mediaData = try? self.loadDataFromURL(mediaURL) else {
            return nil
        }
        os_log(.debug, "got media data")
        
        let fileManager = FileManager.default
        let temporaryFolderName = ProcessInfo.processInfo.globallyUniqueString
        let temporaryFolderURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(temporaryFolderName, isDirectory: true)
        
        do {
            try fileManager.createDirectory(at: temporaryFolderURL,
                                            withIntermediateDirectories: true,
                                            attributes: nil)
            
            let mediaFileIdentifier = "\(UUID().uuidString).\(String(mediaType))"
            let fileURL = temporaryFolderURL.appendingPathComponent(mediaFileIdentifier)
            try mediaData.write(to: fileURL)
            
            return try UNNotificationAttachment(identifier: mediaFileIdentifier, url: fileURL)
        } catch {
            return nil
        }
    }
}

#endif
