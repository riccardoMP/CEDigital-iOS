//
//  CEBehindViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/31/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//



import UIKit


class CEBehindViewController: GenericViewController, ViewControllerProtocol {
    
    
    var userLogin : UserLogin?
    
    @IBOutlet weak var iviSignAuth: UIImageView!
    @IBOutlet weak var iviCE: UIImageView!
    @IBOutlet weak var iviQR: UIImageView!
    @IBOutlet weak var iviFingerPrint: UIImageView!
    @IBOutlet weak var lblResidenceExpirationTitle: UILabel!
    @IBOutlet weak var tviResidenceExpiration: UILabel!
    @IBOutlet weak var tviUbigeoTitle: UILabel!
    @IBOutlet weak var tviUbigeo: UILabel!
    @IBOutlet weak var tviAddressTitle: UILabel!
    @IBOutlet weak var tviAddress: UILabel!
    @IBOutlet weak var lblFinger: UILabel!
    
    
    @IBOutlet weak var sviMRZ_A: UIStackView!
    @IBOutlet weak var sviMRZ_B: UIStackView!
    @IBOutlet weak var sviMRZ_C: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.setup()
        
        
        
    }
    
    func initializeUI() {
        
        
        self.iviCE.layer.cornerRadius = 6
        
        self.iviQR.image = AppUtils.generateQRCode(from: userLogin!.sURL)
        
        lblResidenceExpirationTitle = LabelFluentBuilder.init(label: lblResidenceExpirationTitle)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("dp_ce_title_residence_expiration".localized)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        tviResidenceExpiration = LabelFluentBuilder.init(label: tviResidenceExpiration)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText(userLogin!.sURL)
            .setTextSize(7, UIParameters.TTF_BOLD)
            .build()
        
        
        tviUbigeoTitle = LabelFluentBuilder.init(label: tviUbigeoTitle)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("dp_ce_title_ubigeo".localized)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .setDynamicFont()
            .build()
        
        tviUbigeo = LabelFluentBuilder.init(label: tviUbigeo)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("\(userLogin!.sDepartamentoUbigeo)  /  \(userLogin!.sProvinciaUbigeo)  / \(userLogin!.sDistritoUbigeo)")
            .setTextSize(9, UIParameters.TTF_BOLD)
            .setDynamicFont()
            .build()
        
        tviAddressTitle = LabelFluentBuilder.init(label: tviAddressTitle)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("dp_ce_title_address".localized)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .setDynamicFont()
            .build()
        
        tviAddress = LabelFluentBuilder.init(label: tviAddress)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText(userLogin!.sDomicilio)
            .setTextSize(9, UIParameters.TTF_BOLD)
            .setDynamicFont()
            .build()
        
        
        
        self.fillStackView(arrayCharacter: self.userLogin!.listMRZA!, stackView: sviMRZ_A)
        self.fillStackView(arrayCharacter: self.userLogin!.listMRZB!, stackView: sviMRZ_B)
        self.fillStackView(arrayCharacter: self.userLogin!.listMRZC!, stackView: sviMRZ_C)
        
        lblFinger = LabelFluentBuilder.init(label: lblFinger)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText(userLogin!.sNombreDedo)
            .setTextSize(7, UIParameters.TTF_REGULAR)
            .build()
        
        lblFinger.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        
        
        
        self.iviFingerPrint.image = UIImage(data: self.userLogin!.dataHuellaPersona!)
        
        self.iviSignAuth.image = UIImage(data: self.userLogin!.dataFirmaAutorizada!)
        self.iviSignAuth.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        
        
    }
    
    func setup() {
        
    }
    
    
    func fillStackView( arrayCharacter: [String], stackView: UIStackView){
        
        arrayCharacter.forEach {
            
            
            var characterLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            characterLabel = LabelFluentBuilder.init(label: characterLabel)
                .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
                .setText($0)
                .setTextSize(9, UIParameters.TTF_BOLD)
                .build()
            
            stackView.addArrangedSubview(characterLabel)
            
        }
        
        
        
        
    }
}
