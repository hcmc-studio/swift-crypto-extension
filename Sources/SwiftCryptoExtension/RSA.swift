//
//  File.swift
//  
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import Algorithms

public class RSA {
    private init() {}
    
    public static func encrypt(plain text: String, public key: String, size: Int) throws -> String {
        return try encrypt(plain: text, key: createPublicKey(key: key, size: size))
    }
    
    private static func createPublicKey(key string: String, size: Int) throws -> SecKey {
        guard let keyData = Data(base64Encoded: string) else {
            throw SwiftCryptoExtensionLocalError.RSA.PublicKeyBase64Error
        }
        
        var error: Unmanaged<CFError>?
        guard let key = SecKeyCreateWithData(keyData as CFData, [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass: kSecAttrKeyClassPublic,
            kSecAttrKeySizeInBits: size
        ] as CFDictionary, &error) else {
            throw SwiftCryptoExtensionLocalError.RSA.SecKeyCreateWithDataError
        }
        
        if let error = error {
            throw error.takeRetainedValue()
        }
        
        return key
    }
    
    private static func encrypt(plain text: String, key: SecKey) throws -> String {
        guard let textData = text.data(using: .utf8) else {
            throw SwiftCryptoExtensionLocalError.RSA.PlainTextDecodeError
        }
        let blockSize = SecKeyGetBlockSize(key) - 11
        var buffers = Data()
        for part in textData.chunks(ofCount: blockSize) {
            var error: Unmanaged<CFError>?
            guard let buffer = SecKeyCreateEncryptedData(key, .rsaEncryptionPKCS1, part as CFData, &error) else {
                if let error = error {
                    throw error.takeRetainedValue()
                } else {
                    throw SwiftCryptoExtensionLocalError.RSA.SecKeyCreateEncryptedDataError
                }
            }
            
            buffers.append(buffer as Data)
        }
        
        return buffers.base64EncodedString()
    }
}
