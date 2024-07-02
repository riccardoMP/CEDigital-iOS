//
//  ChooseDocumentViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/9/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//



import UIKit

class ChooseDocumentViewController: GenericViewController, ViewControllerProtocol {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCE: UILabel!
    @IBOutlet weak var iviCE: UIImageView!
    @IBOutlet weak var lblPTP: UILabel!
    @IBOutlet weak var iviPTP: UIImageView!

    
    var coordinator: ChooseDocumentCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.initializeUI()
        self.setup()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtils.lockOrientation(.portrait)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppUtils.lockOrientation(.all)
    }
    
    // MARK: - Method
    
    func initializeUI() {
        lblTitle = LabelFluentBuilder.init(label: lblTitle)
            .setTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
            .setText("cd_title".localized)
            .setTextSize(13, UIParameters.TTF_REGULAR)
            .build()
        
        
        lblCE = LabelFluentBuilder.init(label: lblCE)
            .setTextColor(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setText("cd_ce".localized)
            .setTextSize(13, UIParameters.TTF_BOLD)
            .build()
        
        lblCE.layer.addBorder(edge: UIRectEdge.top, color: #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), thickness: 0.5)
        lblCE.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), thickness: 0.5)
        
        lblPTP = LabelFluentBuilder.init(label: lblPTP)
            .setTextColor(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setText("cd_ptp".localized)
            .setTextSize(13, UIParameters.TTF_BOLD)
            .build()
        
        lblPTP.layer.addBorder(edge: UIRectEdge.top, color: #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), thickness: 0.5)
        lblPTP.layer.addBorder(edge: UIRectEdge.bottom, color: #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), thickness: 0.5)
        
    
        
        
    }
    
    
    func setup() {
        
        
        let post = UserRegisterPostFluentBuilder(builder: UserRegisterPost())
        
        
        iviCE.addTapGestureRecognizer {
            
            ParametryCEFluentBuilder(builder: AppPreferences.shared.parametryCEObject)
                .setIdDocument(idDocumento: Constants.DOCUMENT_TYPE_CE)
                .build()
            
            
            self.coordinator?.coordinateToAuthentication(registerPost:post.setIdDocument(sIdDocumento: Constants.DOCUMENT_TYPE_CE).build())
        }
        
        iviPTP.addTapGestureRecognizer {
            
            ParametryCEFluentBuilder(builder: AppPreferences.shared.parametryCEObject)
                .setIdDocument(idDocumento: Constants.DOCUMENT_TYPE_PTP)
                .build()
            
            self.coordinator?.coordinateToAuthentication(registerPost:post.setIdDocument(sIdDocumento: Constants.DOCUMENT_TYPE_PTP).build())
        }
    }
    
    
    
    // MARK: - Action UIView
    
    
    
    
}


