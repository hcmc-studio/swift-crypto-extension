import XCTest
@testable import SwiftCryptoExtension

final class SwiftCryptoExtensionTests: XCTestCase {
    func RSAEncryptTest() throws {
        let publicKeyString = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCKIh4+ZASrbPYzH0xkBoozen3CaZ1uCRzHyuLelsEUpP2p8OE8cYBVPM7iP8SUjjYAVh2qeEZVqGMuQPM34kRvmJa23qlLNAjEkyoadIjV+s2fCt/qWrP02l9XBF+00d3ihC2a6aZj2o3XO62S2cQFDgEPT7Nh3XhFlfD1/zvQFwIDAQAB"
        let plainText = "Hello World!"
        let encrypted = try RSA.encrypt(plain: plainText, public: publicKeyString, size: 1024)
        Swift.print(encrypted)
    }
}
