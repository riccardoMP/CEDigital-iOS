//
//  CEForwardViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/30/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit


class CEForwardViewController: GenericViewController, ViewControllerProtocol {
    
    
    var userLogin : UserLogin?
    
    @IBOutlet weak var iviCE: UIImageView!
    @IBOutlet weak var lblCE: UILabel!
    
    @IBOutlet weak var iviPhoto: UIImageView!
    @IBOutlet weak var iviSign: UIImageView!
    @IBOutlet weak var vSurname: CETitleValueView!
    @IBOutlet weak var vName: CETitleValueView!
    @IBOutlet weak var vNationality: CETitleValueView!
    @IBOutlet weak var vDateBirth: CETitleValueView!
    @IBOutlet weak var vSex: CETitleValueView!
    @IBOutlet weak var vMigratoryQuality: CETitleValueView!
    @IBOutlet weak var vIssueDate: CETitleValueView!
    @IBOutlet weak var vDateExpiry: CETitleValueView!
    @IBOutlet weak var vMarital: CETitleValueView!
    @IBOutlet weak var vDocumentTravel: CETitleValueView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.setup()
        
        
        
    }
    
    func initializeUI() {
        
        
        self.iviCE.layer.cornerRadius = 6
        
        lblCE = LabelFluentBuilder.init(label: lblCE)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText("CARNÉ DE EXTRANJERÍA N° \(userLogin!.sNumeroCarnet)")
            .setTextSize(9, UIParameters.TTF_BOLD)
            .build()
        
        vSurname.initializeUI(title: "dp_ce_title_surname".localized, value: "\(userLogin!.sPaterno) \(userLogin!.sMaterno)")
        vName.initializeUI(title: "dp_ce_title_name".localized, value: userLogin!.sNombre)
        vNationality.initializeUI(title: "dp_ce_title_nationality".localized, value: userLogin!.sPaisNacimiento)
        vDateBirth.initializeUI(title: "dp_ce_title_birthday".localized, value: userLogin!.dFechaNacimiento)
        vSex.initializeUI(title: "dp_ce_title_sex".localized, value: userLogin!.sSexo)
        vMigratoryQuality.initializeUI(title: "dp_ce_title_migratory_quality".localized, value: "\(userLogin!.sSiglaCalidad ?? "") \(userLogin!.sCalidadMigratoria)")
        vIssueDate.initializeUI(title: "dp_ce_title_issue_date".localized, value: userLogin!.dFechaEmision)
        vDateExpiry.initializeUI(title: "dp_ce_title_expiry_date".localized, value: userLogin!.dFechaCaducidad)
        vMarital.initializeUI(title: "dp_ce_title_marital".localized, value: userLogin!.sIdEstadoCivil)
        vDocumentTravel.initializeUI(title: "dp_ce_title_travel_document".localized, value: "\(userLogin!.sIdDocIdentidad): \(userLogin!.sNumDocIdentidad)")
        
  
        
        self.iviPhoto.image = UIImage(data: self.userLogin!.dataFotoPersona!)
        
        self.iviSign.image = UIImage(data: self.userLogin!.dataFirmaPersona!)
        
        
    }
    
    func setup() {
        
    }
    
    
}
