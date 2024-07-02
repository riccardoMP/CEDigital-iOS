//
//  FacialValidationSDK.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 20/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

/*import UIKit
import Foundation
import FaceTecSDK


class FacialValidationSDK: NSObject, FaceTecFaceScanProcessorDelegate {
    
    private var delegate: FacialValidationProtocol?
    var success = false
    private var fromViewController: UIViewController?
    private var tokenFacialRecognition: FacialRecognition?
    private var postFacialValidation : FacialValidationMigrationPost?
    var faceScanResultCallback: FaceTecFaceScanResultCallback!
    
    init(tokenFacialRecognition: FacialRecognition, delegate: FacialValidationProtocol, fromViewController: UIViewController) {
        self.tokenFacialRecognition = tokenFacialRecognition
        self.delegate = delegate
        self.fromViewController = fromViewController
        
        
        super.init()
    }
    
    
    
    func startFacialValidationSDK()  {
        //
        // Part 1:  Starting the FaceTec Session
        //
        // Required parameters:
        // - delegate:
        // - faceScanProcessorDelegate: A class that implements FaceTecFaceScanProcessor, which handles the FaceScan when the User completes a Session.  In this example, "self" implements the class.
        // - sessionToken:  A valid Session Token you just created by calling your API to get a Session Token from the Server SDK.
        //
        let enrollmentViewController = FaceTec.sdk.createSessionVC(faceScanProcessorDelegate: self, sessionToken: tokenFacialRecognition!.sessionToken)
        
        // In your code, you will be presenting from a UIViewController elsewhere. You may choose to augment this class to pass that UIViewController in.
        // In our example code here, to keep the code in this class simple, we will just get the Sample App's UIViewController statically.
        fromViewController!.present(enrollmentViewController, animated: true, completion: nil)
    }
    
    
    // MARK: - SDK
    
    func processLivenessResponse(data: FacialValidationMigrationResponse){
        if (data.wasProcessed){
            FaceTecCustomization.setOverrideResultScreenSuccessMessage("Liveness\nConfirmado")
            
            self.success = faceScanResultCallback.onFaceScanGoToNextStep(scanResultBlob: data.scanResultBlob ?? "")
            
        }else{
            faceScanResultCallback.onFaceScanResultCancel()
            delegate?.onFacialValidatedFailure(message: "facial_error_sdk".localized)
        }
        
    }
    
    
    func processSessionWhileFaceTecSDKWaits(sessionResult: FaceTecSessionResult, faceScanResultCallback: FaceTecFaceScanResultCallback) {
        
        //
        // DEVELOPER NOTE:  These properties are for demonstration purposes only so the Sample App can get information about what is happening in the processor.
        // In the code in your own App, you can pass around signals, flags, intermediates, and results however you would like.
        //
        
        //fromViewController.setLatestSessionResult(sessionResult: sessionResult)
        
        //
        // DEVELOPER NOTE:  A reference to the callback is stored as a class variable so that we can have access to it while performing the Upload and updating progress.
        //
        self.faceScanResultCallback = faceScanResultCallback
        
        //
        // Part 3: Handles early exit scenarios where there is no FaceScan to handle -- i.e. User Cancellation, Timeouts, etc.
        //
        
        if sessionResult.status != FaceTecSessionStatus.sessionCompletedSuccessfully {
            
            faceScanResultCallback.onFaceScanResultCancel()
            delegate?.onFacialValidatedFailure(message: "facial_error_sdk".localized)
            return
        }
        
        //
        // Part 4:  Get essential data off the FaceTecSessionResult
        //
        
        let persona = PersonValidatePost.createPersonValidatePost(user: AppPreferences.shared.getUser())
        postFacialValidation = FacialValidationMigrationPost(isAuditTrailImage: tokenFacialRecognition!.token, isFaceScan: FaceTec.sdk.createFaceTecAPIUserAgentString(sessionResult.sessionId), isLowQualityAuditTrailImage: sessionResult.auditTrailCompressedBase64![0], isToken: sessionResult.faceScanBase64 ?? "", isXUserAgent: sessionResult.lowQualityAuditTrailCompressedBase64![0], persona: persona)
        
        
        //faceScanResultCallback.onFaceScanResultCancel()
        if let post = postFacialValidation{
            delegate?.onFacialValidatedSDK(post: post)
        }else {
            faceScanResultCallback.onFaceScanResultCancel()
            delegate?.onFacialValidatedFailure(message: "facial_error_sdk".localized)
        }
    }
    
    func isSuccess() -> Bool {
        return success
    }
    
    func cancelLiveness() {
        faceScanResultCallback.onFaceScanResultCancel()
    }
    
    func onFaceTecSDKCompletelyDone() {
        //self.delegate?.onFacialValidatedLiveness(photoBase64: photoBase64 ?? "")
    }
    
    
}
*/
