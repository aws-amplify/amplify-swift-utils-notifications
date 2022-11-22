//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

struct PinpointNotificationPayload: AUNotificationPayload {
    var remoteMediaURL: String? {
        data.mediaURL
    }

    let data: PayloadData
    
    struct PayloadData: Decodable {
        let mediaURL: String
        
        enum CodingKeys: String, CodingKey {
            case mediaURL = "media-url"
        }
    }
}
