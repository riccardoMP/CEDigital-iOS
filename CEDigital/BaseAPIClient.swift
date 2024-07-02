//
//  BaseAPIClient.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 20/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseFirestore

class BaseAPIClient {
    
    
    enum ErrorType: Error {
        case errorException
        case errorGeneric
    }
    

    
    final class AlamofireLogger: EventMonitor {
        func requestDidResume(_ request: Request) {
            let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
            let message = """
            ⚡️ Request Started: \(request)
            ⚡️ Body Data: \(body)
            """
            print(message)
        }
        
        func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value,NetworkMessage>) {
            print("⚡️ Response Received: \(response.debugDescription)")
        }
    }
    
    
    static func sendLogToFirebase(json : String, document: String = "", action: String = "")  {
        let docData: [String: Any] = [
            "messaje": json,
            "date": FieldValue.serverTimestamp(),
            "document" : document,
            "platform" : "iOS",
            "versionApp" : Bundle.main.versionCode!
        ]
        
        
        let nameCollection = (Environment.enviroment.isEmpty) ? "logBiometriciOS" : "logBiometriciOSDev"
        
        let dateDocument = Date().toString(dateFormat: "dd-MM-yyyy HH:mm:ss")
        
        let db = Firestore.firestore()
        db.collection(nameCollection).document("\(action)_\(document)_\(dateDocument)").setData(docData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                //print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    
    
    static let session: Session = {
        
        
        //let manager = ServerTrustManager(allHostsMustBeEvaluated: false,
        //evaluators: ["https://aks-qallarix-ingress-dev.eastus2.cloudapp.azure.com/sami/conversation": DisabledEvaluator()])
        
        if(Environment.enviroment.isEmpty){
            
            return Session(startRequestsImmediately: true,
                           eventMonitors: [ AlamofireLogger() ])
        }else{
            let manager = ServerTrustManager(allHostsMustBeEvaluated: true, evaluators:
                                                ["181.176.222.215": DisabledTrustEvaluator(),
                                                 "integrations.insolutions.pe": DisabledTrustEvaluator()])
            
            var configuration = URLSessionConfiguration.af.default
            
            return Session(startRequestsImmediately: true,
                           serverTrustManager: manager,
                           eventMonitors: [ AlamofireLogger() ])
        }
        
        
        
    }()
}
