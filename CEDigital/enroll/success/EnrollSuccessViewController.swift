//
//  EnrollSuccessViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 12/11/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class EnrollSuccessViewController: GenericViewController, ViewControllerProtocol {
    
    var coordinator: EnrollSuccessCoordinator?
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var butLogin: UIButton!
    
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
    func initializeUI() {
        
        lblDescription = LabelFluentBuilder.init(label: lblDescription)
            .setTextColor(UIParameters.COLOR_GRAY_TEXT)
            .setText("vc_success".localized)
            .setTextSize(15, UIParameters.TTF_BOLD)
            .build()
        
        
        butLogin = ButtonFluentBuilder.init(button: butLogin)
            .setBackground(UIParameters.COLOR_PRIMARY)
            .setTextColor(UIParameters.COLOR_WHITE)
            .setText("general_login".localized)
            .build()
        
    }
    
    func setup() {
        // remove left buttons (in case you added some)
        self.navigationItem.leftBarButtonItems = []
        // hide the default back buttons
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - Action
    
    @IBAction func onSegueLogin(_ sender: Any) {
        self.coordinator?.coordinateToLogin()
    }
}

