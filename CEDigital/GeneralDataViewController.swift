//
//  GeneralDataViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/29/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

class GeneralDataViewController: GenericViewController, ViewControllerProtocol {
    
    
    var coordinator: GeneralDataFlow?
    var userLogin: UserLogin?
    
    
    @IBOutlet weak var tviPersonalData: TextImageHView!
    @IBOutlet weak var vName: LectureView!
    @IBOutlet weak var vLastName: LectureView!
    @IBOutlet weak var vSex: LectureView!
    @IBOutlet weak var vBirthday: LectureView!
    @IBOutlet weak var vNationality: LectureView!
    @IBOutlet weak var vCarne: LectureView!
    
    @IBOutlet weak var tviAddressInformation: TextImageHView!
    @IBOutlet weak var vDepartment: LectureView!
    @IBOutlet weak var vProvince: LectureView!
    @IBOutlet weak var vDistrict: LectureView!
    @IBOutlet weak var vAddress: LectureView!
    
    @IBOutlet weak var tviDocumentTravel: TextImageHView!
    @IBOutlet weak var vTypeDocument: LectureView!
    @IBOutlet weak var vDocument: LectureView!
    
    @IBOutlet weak var tviLastProcedure: TextImageHView!
    @IBOutlet weak var vDescriptionDocument: LectureView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.setup()
        
        
    }
    
    // MARK: - Method
    func initializeUI() {
        
        
        self.titleNavigationBar(title: "dp_general_data".localized)
        
        
        //Personal Data
        tviPersonalData.initializeUI(title: "gd_personal_data".localized, image: "ic_person")
        vName.initializeUI(title: "gd_names".localized, description: userLogin!.sNombre)
        vLastName.initializeUI(title: "gd_surname".localized, description: "\(userLogin!.sPaterno) \(userLogin!.sMaterno)")
        
        let sexValue = (userLogin!.sSexo == AppUtils.EnumSex.MALE.rawValue) ? "gd_male".localized : "gd_female".localized
        vSex.initializeUI(title: "gd_sex".localized, description: sexValue)
        vBirthday.initializeUI(title: "gd_birthday".localized, description: userLogin!.dFechaNacimiento)
        vNationality.initializeUI(title: "gd_nationality".localized, description: userLogin!.sNacionalidad)
        vCarne.initializeUI(title: "gd_carne_number".localized, description: userLogin!.sNumeroCarnet)
        
        
        // Address Information
        tviAddressInformation.initializeUI(title: "gd_address_information".localized, image: "ic_home")
        vDepartment.initializeUI(title: "gd_department".localized, description: userLogin!.sDepartamentoUbigeo)
        vProvince.initializeUI(title: "gd_province".localized, description: userLogin!.sProvinciaUbigeo)
        vDistrict.initializeUI(title: "gd_district".localized, description: userLogin!.sDistritoUbigeo)
        vAddress.initializeUI(title: "gd_address".localized, description: userLogin!.sDomicilio)
        
        
        // Document Travel
        tviDocumentTravel.initializeUI(title: "gd_document_travel".localized, image: "ic_document")
        vTypeDocument.initializeUI(title: "gd_type_document_number".localized, description: userLogin!.sIdDocIdentidad)
        vAddress.initializeUI(title: "gd_address".localized, description: userLogin!.sDomicilio)
        vDocument.initializeUI(title: "gd_document_number".localized, description: userLogin!.sNumDocIdentidad)
        
        
        // Last Procedure
        tviLastProcedure.initializeUI(title: "gd_last_procedure".localized, image: "ic_attach_file")
        vDescriptionDocument.initializeUI(title: "gd_description_document".localized, description: userLogin?.sUltimoTramiteMigra ?? "Inscripción")
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    func setup() {
        
    }
    
}
