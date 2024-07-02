//
//  FourFingerSDK.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 6/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import VeridiumCore
import Veridium4FBiometrics
import AVFoundation

class FourFingerSDK {
    
    
    private var delegate: FourFingerProtocol?
    private var viewController: UIViewController?
    
    init(delegate: FourFingerProtocol, viewController: UIViewController) {
        self.delegate = delegate
        self.viewController = viewController
    }
    
    
    // MARK: - Permission
    
    func checkForCameraPermission() {
        
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
        switch cameraAuthorizationStatus {
            
        case .authorized:
            // Access is granted by user.
            DispatchQueue.main.async {
                self.startFourFingerSDK()
            }
            break
            
        case .notDetermined:
            // It is not determined until now.
            AVCaptureDevice.requestAccess(for: cameraMediaType) { (status) in
                if status == true {
                    DispatchQueue.main.async {
                        self.startFourFingerSDK()
                    }
                }
                else {
                    // Access has been denied.
                }
            }
            break
            
        case .restricted:
            // User do not have access to camera.
            self.askForPermissionWithTitle(title: "general_access_camera".localized)
            break
            
        case .denied:
            // User has denied the permission.
            self.askForPermissionWithTitle(title: "general_access_camera".localized)
            break
        default:
            break
        }
    }
    
    
    private func askForPermissionWithTitle(title:String) {
        let cancelAction = UIAlertAction(title: "general_cancel".localized, style: .cancel) { (_) in
            
        }
        let settingsAction = UIAlertAction(title: "general_settings".localized, style: .default) { (_) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
        
        let actionSheet = UIAlertController(title: "general_access_denied".localized, message: title, preferredStyle: .alert)
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(settingsAction)
        viewController!.present(actionSheet, animated: true) {
            
        }
    }
    
    
    // MARK: - SDK
    func startFourFingerSDK()  {
        
        
        
        let exportConfig = VeridiumFourFCaptureConfig()
        //let fingers: Set<NSNumber>
        
        exportConfig.setHand(VeridiumFourFHandChoice.forceRightHandEnroll)
        
        /*if handSelected == 1 {
         if codigoDerecho == 1 {
         fingers = [NSNumber(integerLiteral: VeridiumFourFFingerChoice.THUMB_RIGHT.rawValue)]
         exportConfig.setFingers(fingers)
         exportConfig.canSwitch = false
         } else {
         exportConfig.setHand(VeridiumFourFHandChoice.forceRightHandEnroll)
         }
         } else {
         if codigoIzquierdo == 6 {
         fingers = [NSNumber(integerLiteral: VeridiumFourFFingerChoice.THUMB_LEFT.rawValue)]
         exportConfig.setFingers(fingers)
         exportConfig.canSwitch = false
         } else {
         exportConfig.setHand(VeridiumFourFHandChoice.forceLeftHandEnroll)
         }
         }*/
        exportConfig.exportFormat = .FORMAT_JSON
        exportConfig.fixed_print_height = 512
        exportConfig.fixed_print_width = 512
        exportConfig.wsq_compression_ratio = COMPRESS_5to1
        exportConfig.pack_raw = false
        exportConfig.pack_wsq = true
        exportConfig.calculate_nfiq = true
        exportConfig.pack_png = false
        exportConfig.pack_bmp = false
        exportConfig.useLiveness = true
        exportConfig.liveness_factor = 99
        exportConfig.targetIndexFinger = false
        exportConfig.targetLittleFinger = false
        exportConfig.do_debug = false
        exportConfig.do_export = true
        exportConfig.pack_audit_image = true
        exportConfig.nist_type = Nist_type_T14_9
        exportConfig.configureTimeoutEnabled(true, withTimeoutCanRestart: true, andTimoutSeconds: 60, andAllowedRetries: .infinite, andAllowSkipping: false)
        
        VeridiumBiometricsFourFService.exportTemplate(exportConfig, onSuccess: { (exportData) in
            do {
                
                
                var arrayBiometric = [BiometricPost]()
                var photoAudit = ""
                
                if let json = try JSONSerialization.jsonObject(with: exportData, options: []) as? [String: Any] {
                    
                    
                    let auditImage = json["AuditImage_0"] as! [String: Any]
                    photoAudit = auditImage["BinaryBase64ObjectJPG"] as! String
                    
                    
                    let fingerprints = json["Fingerprints"]! as! [[String: Any]]
                    
                    
                    for finger in fingerprints {
                        let idFinger = finger["FingerPositionCode"]! as! Int
                        let nfiq = finger["FingerPositionCode"]! as! Int
                        
                        let fingerImpressionImage = finger["FingerImpressionImage"]! as! [String: Any]
                        let wsqBase64 = fingerImpressionImage["BinaryBase64ObjectWSQ"] as! String
                        
                        arrayBiometric.append(BiometricPost(nIdDedo: idFinger, xDedoConsultado: wsqBase64, nScore: nfiq))
                    }
                    
        
                    self.delegate?.onFourFingerProcessed(arrayBiometric: arrayBiometric, photoAudit: photoAudit)
                    
                } else {
                    print("error")
                    
                    self.delegate?.onFourFingerFailure(message: "biometric_error_parser".localized)
                    //ISVeridiumTracker.VeridiumTracker.shared.trackEvent(name: String(describing: self), category: "FaceFingerDemo", action: "Veridium", label: "Captura", value: "Revisar")
                    
                    
                }
            } catch {
                print(error)
                self.delegate?.onFourFingerFailure(message: error.localizedDescription)
                //ISVeridiumTracker.VeridiumTracker.shared.trackEvent(name: String(describing: self), category: "FaceFingerDemo", action: "Veridium", label: "Captura", value: "Error: \(error)")
                
            }
        }, onFail: {
            
            self.delegate?.onFourFingerFailure(message: "biometric_error_parser".localized)
            //ISVeridiumTracker.VeridiumTracker.shared.trackEvent(name: String(describing: self), category: "FaceFingerDemo", action: "Veridium", label: "Captura", value: "Error")
            
        }, onCancel: {
            self.delegate?.onFourFingerFailure(message: "biometric_error_parser".localized)
            //ISVeridiumTracker.VeridiumTracker.shared.trackEvent(name: String(describing: self), category: "FaceFingerDemo", action: "Veridium", label: "Captura", value: "Cancelado")
            
        }, onError: {
            (error) in
            
            self.delegate?.onFourFingerFailure(message: error.localizedDescription)
            //ISVeridiumTracker.VeridiumTracker.shared.trackEvent(name: String(describing: self), category: "FaceFingerDemo", action: "Veridium", label: "Captura", value: "Error: \(error)")
            
        })
    }
    
    
    
}

