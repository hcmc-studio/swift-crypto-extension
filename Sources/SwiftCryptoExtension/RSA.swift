//
//  File.swift
//  
//
//  Created by Ji-Hwan Kim on 10/15/23.
//

import Foundation
import Algorithms

public final class RSA {
    private init() {}
    
    public static func encrypt(string plain: String, public key: String, size: Int) throws -> String {
        guard let data = plain.data(using: .utf8) else {
            throw SwiftCryptoExtensionLocalError.RSA.StringToDataError
        }
        
        return try encrypt(data: data, public: key, size: size)
    }
    
    public static func encrypt(object plain: any Encodable, encoder: JSONEncoder, public key: String, size: Int) throws -> String {
        let data = try encoder.encode(plain)
        
        return try encrypt(data: data, public: key, size: size)
    }
    
    public static func encrypt(data: Data, public key: String, size: Int) throws -> String {
        let key = try convert(publicKey: key, size: size)
        
        return try encrypt(data: data, key: key)
    }
    
    private static func convert(publicKey string: String, size: Int) throws -> SecKey {
        guard let keyData = Data(base64Encoded: string) else {
            throw SwiftCryptoExtensionLocalError.RSA.PublicKeyError
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
    
    private static func encrypt(data: Data, key: SecKey) throws -> String {
        let blockSize = SecKeyGetBlockSize(key) - 11
        var buffers = Data()
        for part in data.chunks(ofCount: blockSize) {
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
