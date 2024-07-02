//
//  PTPForwardViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/1/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class PTPForwardViewController: GenericViewController, ViewControllerProtocol {
    
    
    var userLogin : UserLogin?
    
    @IBOutlet weak var iviPTP: UIImageView!
    @IBOutlet weak var lblPTP: UILabel!
    @IBOutlet weak var lblNumberPTP: UILabel!
    
    @IBOutlet weak var iviPhoto: UIImageView!
    @IBOutlet weak var iviSign: UIImageView!
    @IBOutlet weak var lblSurnameTitle: UILabel!
    @IBOutlet weak var lblSurname: UILabel!
    @IBOutlet weak var lblNameTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNationalityTitle: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblBirthdayTitle: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblCivilStateTitle: UILabel!
    @IBOutlet weak var lblCivilState: UILabel!
    @IBOutlet weak var lblSexTitle: UILabel!
    @IBOutlet weak var lblSex: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.setup()
        
        
        
    }
    
    func initializeUI() {
        
        
        self.iviPTP.layer.cornerRadius = 6
        
        lblPTP = LabelFluentBuilder.init(label: lblPTP)
            .setTextColor(#colorLiteral(red: 0.262745099, green: 0.262745099, blue: 0.262745099, alpha: 1))
            .setText("dp_ptp_title".localized)
            .setTextSize(9, UIParameters.TTF_BOLD)
            .build()
        
        lblNumberPTP = LabelFluentBuilder.init(label: lblNumberPTP)
            .setTextColor(#colorLiteral(red: 0.262745099, green: 0.262745099, blue: 0.262745099, alpha: 1))
            .setText("N° \(userLogin!.sNumeroCarnet)")
            .setTextSize(16, UIParameters.TTF_BOLD)
            .build()
        
        //Surname
        lblSurnameTitle = LabelFluentBuilder.init(label: lblSurnameTitle)
            .setTextColor(#colorLiteral(red: 0.262745099, green: 0.262745099, blue: 0.262745099, alpha: 1))
            .setText("dp_ptp_title_surname".localized)
            .setTextSize(7, UIParameters.TTF_REGULAR)
            .build()
        
        lblSurname = LabelFluentBuilder.init(label: lblSurname)
            .setTextColor(#colorLiteral(red: 0.262745099, green: 0.262745099, blue: 0.262745099, alpha: 1))
            .setText("\(userLogin!.sPaterno) \(userLogin!.sMaterno)")
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        //Name
        
        lblNameTitle = LabelFluentBuilder.init(label: lblNameTitle)
            .setTextColor(#colorLiteral(red: 0.262745099, green: 0.262745099, blue: 0.262745099, alpha: 1))
            .setText("dp_ptp_title_name".localized)
            .setTextSize(7, UIParameters.TTF_REGULAR)
            .build()
        
        lblName = LabelFluentBuilder.init(label: lblName)
            .setTextColor(#colorLiteral(red: 0.262745099, green: 0.262745099, blue: 0.262745099, alpha: 1))
            .setText(userLogin!.sNombre)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        //Nationality
        lblNationalityTitle = LabelFluentBuilder.init(label: lblNationalityTitle)
            .setTextColor(#colorLiteral(red: 0.262745099, green: 0.262745099, blue: 0.262745099, alpha: 1))
            .setText("dp_ptp_title_nationality".localized)
            .setTextSize(7, UIParameters.TTF_REGULAR)
            .build()
        
        lblNationality = LabelFluentBuilder.init(label: lblNationality)
            .setTextColor(#colorLiteral(red: 0.262745099, green: 0.262745099, blue: 0.262745099, alpha: 1))
            .setText(userLogin!.sPaisNacimiento)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        //Birthday
        lblBirthdayTitle = LabelFluentBuilder.init(label: lblBirthdayTitle)
            .setTextColor(#colorLiteral(red: 0.262745099, green: 0.262745099, blue: 0.262745099, alpha: 1))
            .setText("dp_ptp_title_birthday".localized)
            .setTextSize(7, UIParameters.TTF_REGULAR)
            .build()
        
        lblBirthday = LabelFluentBuilder.init(label: lblBirthday)
            .setTextColor(#colorLiteral(red: 0.262745099, green: 0.262745099, blue: 0.262745099, alpha: 1))
            .setText(userLogin!.dFechaNacimiento)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        //Civil State
        lblCivilStateTitle = LabelFluentBuilder.init(label: lblCivilStateTitle)
            .setTextColor(#colorLiteral(red: 0.262745099, green: 0.262745099, blue: 0.262745099, alpha: 1))
            .setText("dp_ptp_title_civil_state".localized)
            .setTextSize(7, UIParameters.TTF_REGULAR)
            .build()
        
        lblCivilState = LabelFluentBuilder.init(label: lblCivilState)
            .setTextColor(#colorLiteral(red: 0.262745099, green: 0.262745099, blue: 0.262745099, alpha: 1))
            .setText(userLogin!.sIdEstadoCivil)
            .setTextSize(9, UIParameters.TTF_REGULAR)
            .build()
        
        
     
        
        self.iviPhoto.image = UIImage(data: self.userLogin!.dataFotoPersona!)
        
        self.iviSign.image = UIImage(data: self.userLogin!.dataFirmaPersona!)
        
        
    }
    
    func setup() {
        
    }
    
    
}
