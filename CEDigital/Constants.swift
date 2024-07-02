//
//  Constants.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/9/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import Foundation

public struct Constants{
    
    //General

    static var NO_SELECTED                        = 1024
    static var PHONE_WHATSAPP_MOVISTAR            = "999955555"
    static var APP_NAMEDAY:Int                    = 2020 //Year where the app was launched, valar morghulis
    static var APP_BIRTHDAY                       = "03/06/2019" //Year where the app was launched, valar morghulis
    static var APP_STORE_MOVISTAR_CONTIGO         = "https://apps.apple.com/us/app/movistar-contigo/id1460599036"
    static var NAVIGATION_MAIN                    = 1
    
    static var DOCUMENT_TYPE_CE = "CE"
    static var DOCUMENT_TYPE_PTP = "PTP"
    
    //Webservices
    static var PREFERENCES_NAME                = "PREF_QALLARIX"
    static var MIGRACIONES_WEB                 = "https://www.migraciones.gob.pe/"
    static var MIGRATIONS_DIGITAL_AGENCY       = "https://agenciavirtual.migraciones.gob.pe/agencia-virtual/identidad"
    

    
    
    //Preferences
    static var PREF_HEIGHT_CELL              = "prefHeightCell"
    static var PREF_IS_CODE_VALIDATED        = "prefIsCodeValidated"
    static var PREF_EMPLOYEE_STORED          = "prefEmployeeStored"
    static var PREF_LEADERSHIP_STORED        = "prefLeadershipStored"
    static var PREF_TOKEN_FIREBASE_STORED    = "prefTokenFirebase"
    

    
    //Dates
    static var DATE_FORMAT_DAY              = "dd"
    static var DATE_FORMAT_DATE             = "dd/MM/yyyy"
    static var DATE_FORMAT_DATETIME         = "dd/MM/yyyy HH:mm:ss"
    static var DATE_FORMAT_MONTH_NAME       = "MMMM"
    
    
    //Apple Hardcoded values
    static var APPLE_DOCUMENT_CE               = "011235813"
    
    
    
    
    //Notification Keys
    
    static var NOTIF_KEY_ACTION_CLICK_DASHBOARD         = "actionClickDashboard"
    
    
    
    //Notification User Info
    static var NOTIF_USERINFO_DASHBOARD            = "ACTION_DASBOARD"
    static var NOTIF_USERINFO_ACTION_OPTION        = "ACTION_OPTION"
    
    
    /*Regex*/
    static var REGEX_EMAIL = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    static var REGEX_PHONE = "[0-9]{9}"
    static var REGEX_DOCUMENT = "^.{9}$"
    static var REGEX_PROCEDURE = "^.{11}$"
    static var REGEX_PASSWORD = "^([A-Z])(?=.*[0-9]).{7,16}$"
    static var REGEX_CODE = "^.{6}$"

    static var REGEX_MASKING_EMAIL = "(?<=.{2}).(?=.{2}[^@]*?@)"
    static var REGEX_MASKING_PHONE = "(?<=.{2}).(?=.{2})"
    
    
  
    
}
