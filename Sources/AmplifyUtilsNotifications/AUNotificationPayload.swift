//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Defines the location of the media URL in a notification payload.
///
/// Conform to this protocol to define notification payload formats for use with AUNotificationService.
/// It is not necessary to define the full message schema. Defining the subset of the message that
/// contains the remote media URL is sufficient. See `PinpointNotificationPayload` for an example.
///
/// Supported Media Types:
///
/// Audio - 5MB max
/// - kUTTypeAudioInterchangeFileFormat
/// - kUTTypeWaveformAudio
/// - kUTTypeMP3
/// - kUTTypeMPEG4Audio
///
/// Image - 10 MB max
/// - kUTTypeJPEG
/// - kUTTypeGIF
/// - kUTTypePNG
///
/// Movie - 50 MB max
/// - kUTTypeMPEG
/// - kUTTypeMPEG2Video
/// - kUTTypeMPEG4
/// - kUTTypeAVIMovie
///
public protocol AUNotificationPayload: Decodable {
    var remoteMediaURL: String? { get }
}

extension AUNotificationPayload {
    init(decoding userInfo: [AnyHashable : Any]) throws {
        let json = try JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
        self = try JSONDecoder().decode(Self.self, from: json)
    }
}
