//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

enum AmplifyTest {}

extension AmplifyTest {
    static func randomAlphabet(length: Int = 8) -> String {
        assert(length > 0)
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }

    static func randomNumeric(length: Int = 8) -> String {
        assert(length > 0)
        let letters = "0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }

    static func randomAlphanumeric(length: Int = 8) -> String {
        assert(length > 0)
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
