//
//  QRLectureViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/29/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

class QRLectureViewController: GenericViewController, ViewControllerProtocol {
    
    
    var coordinator: QRLectureFlow?
    var userLogin: UserLogin?
    
    @IBOutlet weak var iviQR: UIImageView!
    @IBOutlet weak var lblDisclaimer: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.setup()
        
        
        
    }
    
    func initializeUI() {
    
        
        self.titleNavigationBar(title: "qr_title".localized)
        
        //let qrString = "\(userLogin!.sURLQR)\(userLogin!.sEncriptado)"
        let qrString = "https://172.27.130.155/visor-qr/consulta/\(userLogin!.sEncriptado)"
        self.iviQR.image = AppUtils.generateQRCode(from: qrString)
        
        lblDisclaimer = LabelFluentBuilder.init(label: lblDisclaimer)
            .setTextColor(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setText("qr_disclaimer".localized)
            .setTextSize(15, UIParameters.TTF_LIGHT)
            .build()
        
    }
    
    func setup() {
        
    }
    
}
