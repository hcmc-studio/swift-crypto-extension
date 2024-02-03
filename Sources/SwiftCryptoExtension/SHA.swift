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
    
    public static func hash(
        to256 text: String,
        using encoding: String.Encoding = .utf8
    ) throws -> String {
        guard let data = text.data(using: encoding) else {
            throw SwiftCryptoExtensionLocalError.SHA.PlainTextError
        }
        let hash = CryptoKit.SHA256.hash(data: data)
        
        return hexString(data: .init(hash))
    }
    
    public static func hash(
        to384 text: String,
        using encoding: String.Encoding = .utf8
    ) throws -> String {
        guard let data = text.data(using: encoding) else {
            throw SwiftCryptoExtensionLocalError.SHA.PlainTextError
        }
        let hash = CryptoKit.SHA384.hash(data: data)
        
        return hexString(data: .init(hash))
    }
    
    public static func hash(
        to512 text: String,
        using encoding: String.Encoding = .utf8
    ) throws -> String {
        guard let data = text.data(using: encoding) else {
            throw SwiftCryptoExtensionLocalError.SHA.PlainTextError
        }
        let hash = CryptoKit.SHA512.hash(data: data)
        
        return hexString(data: .init(hash))
    }
    
    private static func hexString(data: Data) -> String {
        var hex = ""
        for byte in data {
            hex += .init(format: "%02x", byte)
        }
        
        return hex
    }
}
