//
//  RecoverySuccessViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/8/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class RecoverySuccessViewController: GenericViewController, ViewControllerProtocol {
    
    var coordinator: RecoverySuccessFlow?
    
    @IBOutlet weak var lblPasswordUpdate: UILabel!
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
        
        lblPasswordUpdate = LabelFluentBuilder.init(label: lblPasswordUpdate)
            .setTextColor(UIParameters.COLOR_GRAY_TEXT)
            .setText("recovery_success".localized)
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

