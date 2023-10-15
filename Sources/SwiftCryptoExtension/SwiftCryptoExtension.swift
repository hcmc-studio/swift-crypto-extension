import Foundation

public class SwiftCryptoExtensionLocalError {
    private init() {}
    
    public class RSA {
        private init() {}
        public static let domain = "studio.hcmc.crypto.rsa"
        public static let PublicKeyBase64Error = NSError(domain: domain, code: -1)
        public static let SecKeyCreateWithDataError = NSError(domain: domain, code: -2)
        public static let PlainTextDecodeError = NSError(domain: domain, code: -3)
        public static let SecKeyCreateEncryptedDataError = NSError(domain: domain, code: -4)
    }
}
