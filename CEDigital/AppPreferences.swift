//
//  AppPreferences.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/9/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }
}

class AppPreferences {
    let userDefaults = UserDefaults(suiteName: "group.sharedForExtensions")!//UserDefaults.standard
    
    class var shared: AppPreferences {
        struct Static {
            static let instance = AppPreferences()
        }
        
        return Static.instance
    }
    
    func clear() {
        //UserDefaults.standard.removePersistentDomain(forName: "group.sharedForExtensions")
        //UserDefaults.standard.synchronize()
    }
    
    
    func getUser() -> UserCE {
        
        if let user =  try? UserCE.decode(data: self.prefUserStored!){
            
            return user
        }else{
            
            return UserCE(sNumeroCarnet: "", sNumeroTramite: "", uIdPersona: "", sNombre: "", sPaterno: "", sMaterno: "", sEmail: "", sTelefono: "", dFechaNacimiento: "", bAnulado : false, dFechaVenc: "", dFechaAnulacion : "")
        }
        
    }
    
    
    var parametryCEObject: ParametryCE {
        get {
            if let parametry =  try? ParametryCE.decode(data: self.parametryCE!){
                
                return parametry
            }else{
                return ParametryCE()
            }
        }
        set {
            
            self.parametryCE = AppUtils.encodeObject(newValue)
        }
    }
    
    // MARK: - Apps Value
    
    

    var bearerToken: String? {
        get {
            return userDefaults[#function] ?? ""
        }
        set {
            userDefaults[#function] = newValue
        }
    }
    
    var parametryCE: Data? {
        get {
            return userDefaults[#function] ?? Data()
        }
        set {
            userDefaults[#function] = newValue
        }
    }
    

    var prefUserStored: Data? {
        get {
            return userDefaults[#function] ?? Data()
        }
        set {
            userDefaults[#function] = newValue
        }
    }
    
    var prefHeightCell: Float? {
        get {
            return userDefaults[#function] ?? 0.0
        }
        set {
            userDefaults[#function] = newValue
        }
    }
    
    
}
