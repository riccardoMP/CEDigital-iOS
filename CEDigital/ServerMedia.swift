//
//  ServerMedia.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 30/07/24.
//  Copyright © 2024 Riccardo Mija Padilla. All rights reserved.
//

import Foundation


struct ServerMedia: Codable{
    var mediaData: Data
    var name: String
    var mimeType: String
}

