//
//  RSAKeyManager.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 10/19/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//  https://medium.com/@nipunr/end-to-end-encryption-ios-android-rsa-65cfd015184a


import UIKit
import SwiftyRSA
class RSAKeyManager {
    public static let KEY_SIZE = 2048
    private var publicKey, privateKey: SecKey?
    
    private let tagPrivate = "\(String(describing: Bundle.main.bundleIdentifier)).tagPrivate"
    private let tagPublic  = "\(String(describing: Bundle.main.bundleIdentifier)).tagPublic"
    
    static let shared = RSAKeyManager()
    let exportImportManager = CryptoExportImportManager()
    
    public func getMyPublicKey() -> PublicKey? {
        do {
            if let pubKey = publicKey {
                return try PublicKey(reference: pubKey)
            } else {
                if getKeysFromKeychain(), let pubKey = publicKey {
                    return try PublicKey(reference: pubKey)
                } else {
                    generateKeyPair()
                    if let pubKey = publicKey {
                        return try PublicKey(reference: pubKey)
                    }
                }
            }
        } catch _ {
            //Log Error
            return nil
        }
        return nil
    }
    
    public func getMyPrivateKey() -> PrivateKey? {
        do {
            if let privKey = privateKey {
                return try PrivateKey(reference: privKey)
            } else {
                if getKeysFromKeychain(), let privKey = privateKey {
                    return try PrivateKey(reference: privKey)
                } else {
                    generateKeyPair()
                    if let privKey = privateKey {
                        return try PrivateKey(reference: privKey)
                    }
                }
            }
        } catch _ {
            //Log Error
            return nil
        }
        return nil
    }
    
    public func getMyPublicKeyString(pemEncoded: String) -> PublicKey? {
        do {
            return try PublicKey(pemEncoded: pemEncoded)
        } catch _ {
            //Log Error
            return nil
        }
    }
    
    //Check Keychain and get keys
    private func getKeysFromKeychain() -> Bool {
        privateKey = getKeyTypeInKeyChain(tag: tagPrivate)
        publicKey = getKeyTypeInKeyChain(tag: tagPublic)
        return ((privateKey != nil)&&(publicKey != nil))
    }
    
    private func getKeyTypeInKeyChain(tag : String) -> SecKey? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassKey,
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrApplicationTag: tag,
            kSecReturnRef: true
        ]
        
        var result : AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess {
            return result as! SecKey?
        }
        return nil
    }
    
    //Generate private and public keys
    private func generateKeyPair() {
        let privateKeyAttr: [CFString: Any] = [
            kSecAttrIsPermanent: true,
            kSecAttrApplicationTag: tagPrivate
        ]
        let publicKeyAttr: [CFString: Any] = [
            kSecAttrIsPermanent: true,
            kSecAttrApplicationTag: tagPublic
        ]
        
        let parameters: [CFString: Any] = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits: RSAKeyManager.KEY_SIZE,
            kSecPrivateKeyAttrs: privateKeyAttr,
            kSecPublicKeyAttrs: publicKeyAttr
        ]
        
        let status = SecKeyGeneratePair(parameters as CFDictionary, &publicKey, &privateKey)
        //self.updatePublicKey()
        
        if status != noErr {
            //Log Error
            return
        }
    }
    
    public func getMyPublicKeyString() -> String? {
        
        guard let pubKey = self.getMyPublicKey()  else {
            return nil
        }
        
        do{
            
            return exportImportManager.exportRSAPublicKeyToPEM(try pubKey.data(), keyType: kSecAttrKeyTypeRSA as String, keySize: RSAKeyManager.KEY_SIZE)
        }catch _ {
            //Log Error
            return nil
        }
        
    }
    
    //Delete keys when required.
    public func deleteAllKeysInKeyChain() {
        let query : [CFString: Any] = [
            kSecClass: kSecClassKey
        ]
        let status = SecItemDelete(query as CFDictionary)
        
        switch status {
        case errSecItemNotFound: break
        //No key in keychain
        case noErr: break
        //All Keys Deleted
        default: break
        //Log Error
        }
    }
}
