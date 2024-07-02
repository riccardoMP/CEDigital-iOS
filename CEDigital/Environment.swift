//
//  Environment.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/4/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//https://thoughtbot.com/blog/let-s-setup-your-ios-environments
//https://medium.com/better-programming/how-to-create-development-staging-and-production-configs-in-xcode-ec58b2cc1df4
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let rootURL          = "XCC_ROOT_URL"
            static let enviroment       = "XCC_ENVIROMENT"
            static let faceToken        = "XCC_FACE_TOKEN"
            
            static let veridiumConfigDeviceKey   = "XCC_VERIDIUM_CONFIG_DEVICE_KEY"
            static let veridiumConfigProductKey  = "XCC_VERIDIUM_CONFIG_PRODUCT_KEY"
            static let veridiumConfigPublicKey   = "XCC_VERIDIUM_CONFIG_PUBLIC_KEY"
            
           
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
 
    
    static let rootURL: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.rootURL] as? String else {
            fatalError("rootURL not set in plist for this environment")
        }
        return apiKey
    }()
    
    static let enviroment: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.enviroment] as? String else {
            fatalError("enviroment not set in plist for this environment")
        }
        return apiKey
    }()
    
    
    
    // MARK: - Veridium
    static let veridiumConfigDeviceKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.veridiumConfigDeviceKey] as? String else {
            fatalError("veridiumConfigDeviceKey not set in plist for this environment")
        }
        return apiKey
    }()
    
    static let veridiumConfigProductKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.veridiumConfigProductKey] as? String else {
            fatalError("veridiumConfigProductKey not set in plist for this environment")
        }
        return apiKey
    }()
    
    static let veridiumConfigPublicKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.veridiumConfigPublicKey] as? String else {
            fatalError("veridiumConfigPublicKey not set in plist for this environment")
        }
        return apiKey
    }()
    
    
    
    static let faceToken: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.faceToken] as? String else {
            fatalError("faceToken not set in plist for this environment")
        }
        return apiKey
    }()
    
}
