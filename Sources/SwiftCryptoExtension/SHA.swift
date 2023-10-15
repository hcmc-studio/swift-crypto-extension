//
//  File.swift
//  
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import CryptoKit

public final class SHA {
    private init() {}
    
    public static func hash512(plain text: String) throws -> String {
        guard let data = text.data(using: .utf8) else {
            throw SwiftCryptoExtensionLocalError.SHA.PlainTextError
        }
        let hash = CryptoKit.SHA512.hash(data: data)
        let hashData = Data(hash)
        var hex: String = ""
        for byte in hashData {
            hex += .init(format: "%02x", byte)
        }
        
        return hex
    }
}
