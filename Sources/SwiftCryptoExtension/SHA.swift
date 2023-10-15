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
    
    public static func hash(plain text: String) throws -> String {
        guard let data = text.data(using: .utf8) else {
            throw SwiftCryptoExtensionLocalError.SHA.PlainTextError
        }
        let hash = CryptoKit.SHA512.hash(data: data)
        let hashData = Data(hash)
        if let s = String(data: hashData, encoding: .utf8) {
            return s
        } else {
            throw SwiftCryptoExtensionLocalError.SHA.DigestDataError
        }
        
    }
}
