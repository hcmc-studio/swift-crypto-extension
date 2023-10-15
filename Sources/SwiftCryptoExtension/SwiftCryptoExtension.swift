import Foundation

public final class SwiftCryptoExtensionLocalError {
    private init() {}
    
    public class RSA {
        private init() {}
        public static let domain = "studio.hcmc.crypto.rsa"
        public static let PublicKeyError                    = NSError(domain: domain, code: -1)
        public static let SecKeyCreateWithDataError         = NSError(domain: domain, code: -2)
        public static let PlainTextError                    = NSError(domain: domain, code: -3)
        public static let SecKeyCreateEncryptedDataError    = NSError(domain: domain, code: -4)
    }
    
    public final class SHA {
        private init() {}
        public static let domain = "studio.hcmc.crypto.sha"
        public static let PlainTextError                    = NSError(domain: domain, code: -1)
        public static let DigestDataError                   = NSError(domain: domain, code: -2)
    }
}
