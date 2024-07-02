//
//  TermsConditionViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/19/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

class TermsConditionViewController: GenericViewController, ViewControllerProtocol {
    
    
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTermsCondition: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var butDone: UIButton!
    
    
    
    // MARK: - Cycle Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.initializeUI()
        self.setup()
    }
    
    
    // MARK: - Setup y UI
    
    func initializeUI(){
        
        self.contentView.layer.borderWidth = 1.2
        self.contentView.layer.borderColor = UIParameters.COLOR_GRAY_SEPARATOR.cgColor
        self.contentView.layer.cornerRadius = 6
        view.blurBackground(style: .light, fallbackColor: UIParameters.COLOR_VACATION_BLACK_04)
        
        lblTitle = LabelFluentBuilder.init(label: lblTitle)
            .setTextColor(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setText("gp_dialog_title".localized)
            .setTextSize(20, UIParameters.TTF_BOLD)
            .build()
        
        lblTermsCondition = LabelFluentBuilder.init(label: lblTermsCondition)
            .setTextColor(#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1))
            .setText("general_terms_Condition".localized)
            .setTextSize(14, UIParameters.TTF_LIGHT)
            .build()
        
        butDone = ButtonFluentBuilder.init(button: butDone)
            .setBackground(#colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1))
            .setTextColor(UIParameters.COLOR_WHITE)
            .setText("general_ok".localized)
            .build()
        
        
    }
    
    func setup() {
        
    }
    
    
    // MARK: - Action UIView
    
    
    @IBAction func doneClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
}

