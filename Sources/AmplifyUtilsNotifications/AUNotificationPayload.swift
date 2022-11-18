//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Defines the location of the image URL in a notification payload.
///
/// Conform to this protocol to define notification payload formats for use with AUNotificationService.
/// It is not necessary to define the full message schema. Defining the subset of the message that
/// contains the remote image URL is sufficient. See `PinpointNotificationPayload` for an example.
public protocol AUNotificationPayload: Decodable {
    var remoteImageURL: String? { get }
    var remoteSoundURL: String? { get }
}

extension AUNotificationPayload {
    init(decoding userInfo: [AnyHashable : Any]) throws {
        let json = try JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
        self = try JSONDecoder().decode(Self.self, from: json)
    }
}
