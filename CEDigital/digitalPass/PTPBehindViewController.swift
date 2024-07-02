//
//  PTPBehindViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/1/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class PTPBehindViewController: GenericViewController, ViewControllerProtocol {
    
    
    var userLogin : UserLogin?
    
    @IBOutlet weak var iviSignAuth: UIImageView!
    @IBOutlet weak var iviPTP: UIImageView!
    @IBOutlet weak var iviFingerPrint: UIImageView!
    @IBOutlet weak var lblDepartment: UILabel!
    @IBOutlet weak var lblDistrict: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPassportNumberTitle: UILabel!
    @IBOutlet weak var lblPassportNumber: UILabel!
    @IBOutlet weak var lblApprobationDateTitle: UILabel!
    @IBOutlet weak var lblApprobationDate: UILabel!
    @IBOutlet weak var lblBroadcastDateTitle: UILabel!
    @IBOutlet weak var lblBroadcastDate: UILabel!
    @IBOutlet weak var lblExpirationDateTitle: UILabel!
    @IBOutlet weak var lblExpirationDate: UILabel!
    @IBOutlet weak var lblExpedition: UILabel!
    
    @IBOutlet weak var sviMRZ_A: UIStackView!
    @IBOutlet weak var sviMRZ_B: UIStackView!
    
    
    @IBOutlet weak var lblMRZ: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.setup()
        
        
        
    }
    
    func initializeUI() {
        
        
        self.iviPTP.layer.cornerRadius = 6
        
        lblDepartment = LabelFluentBuilder.init(label: lblDepartment)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("Departamento:  \(userLogin!.sDepartamentoUbigeo)    Provincia:  \(userLogin!.sProvinciaUbigeo)")
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        lblDistrict = LabelFluentBuilder.init(label: lblDistrict)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("Distrito:  \(userLogin!.sDistritoUbigeo)")
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        
        lblAddress = LabelFluentBuilder.init(label: lblAddress)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("Dirección:  \(userLogin!.sDomicilio)")
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .setDynamicFont()
            .build()
        
        //Passport Number
        lblPassportNumberTitle = LabelFluentBuilder.init(label: lblPassportNumberTitle)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("N° \(userLogin!.sIdDocIdentidad):")
            
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        lblPassportNumber = LabelFluentBuilder.init(label: lblPassportNumber)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText(userLogin!.sNumDocIdentidad)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        //Approbation Date
        lblApprobationDateTitle = LabelFluentBuilder.init(label: lblApprobationDateTitle)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("dp_ptp_title_approbation_date".localized)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        lblApprobationDate = LabelFluentBuilder.init(label: lblApprobationDate)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText(userLogin!.dFechaInscripcion)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        //Broadcast Date
        lblBroadcastDateTitle = LabelFluentBuilder.init(label: lblBroadcastDateTitle)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("dp_ptp_title_broadcast_date".localized)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        lblBroadcastDate = LabelFluentBuilder.init(label: lblBroadcastDate)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText(userLogin!.dFechaEmision)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        //tviExpiration Date
        lblExpirationDateTitle = LabelFluentBuilder.init(label: lblExpirationDateTitle)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("dp_ptp_title_expiration_date".localized)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        lblExpirationDate = LabelFluentBuilder.init(label: lblExpirationDate)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText(userLogin!.dFechaCaducidad)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        lblExpedition = LabelFluentBuilder.init(label: lblExpedition)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("Lug. Expedición: \(userLogin!.sLugarExpedicion ?? "")")
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        
        
        /*lblMRZ = LabelFluentBuilder.init(label: lblMRZ)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("\(userLogin!.sMRZFilaA)\n\(userLogin!.sMRZFilaB))")
            .setTextSize(9, UIParameters.TTF_BOLD)
            .build()*/
        
        
        self.iviFingerPrint.image = UIImage(data: self.userLogin!.dataHuellaPersona!)
        self.iviSignAuth.image = UIImage(data: self.userLogin!.dataFirmaAutorizada!)
        self.iviSignAuth.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        self.fillStackView(arrayCharacter: self.userLogin!.listMRZA!, stackView: sviMRZ_A)
        self.fillStackView(arrayCharacter: self.userLogin!.listMRZB!, stackView: sviMRZ_B)
        
        
        
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
                .setTextSize(11, UIParameters.TTF_BOLD)
                .build()
            
            stackView.addArrangedSubview(characterLabel)
            
        }
        
        
        
        
    }
    
}

