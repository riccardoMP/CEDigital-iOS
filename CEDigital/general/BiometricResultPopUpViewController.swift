//
//  BiometricResultPopUpViewController.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 11/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class BiometricResultPopUpViewController: GenericViewController, ViewControllerProtocol {
    
    
    @IBOutlet weak var iviImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var butOk: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var biometricPopUp: BiometricLecturePopUp?
    var delegatePopUp: PopUpResponseProtocol?
    
    // MARK: - Cycle Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initializeUI()
        setup()
        
    }
    
    
    // MARK: - Setup y UI
    
    func initializeUI(){
        
        self.contentView.layer.borderWidth = 1.2
        self.contentView.layer.borderColor = UIParameters.COLOR_GRAY_SEPARATOR.cgColor
        self.contentView.layer.cornerRadius = 6
        view.blurBackground(style: .light, fallbackColor: UIParameters.COLOR_VACATION_BLACK_04)
        
        
        lblTitle = LabelFluentBuilder.init(label: lblTitle)
            .setTextColor(UIParameters.COLOR_GRAY_TEXT)
            .setText(biometricPopUp!.title)
            .setTextSize(20, UIParameters.TTF_BOLD)
            .build()
        
        lblDescription = LabelFluentBuilder.init(label: lblDescription)
            .setTextColor(UIParameters.COLOR_GRAY_TEXT)
            .setText(biometricPopUp!.description)
            .setTextSize(14, UIParameters.TTF_LIGHT)
            .build()
        
        butOk = ButtonFluentBuilder.init(button: butOk)
            .setTextColor(UIParameters.COLOR_WHITE)
            .setBackground(UIParameters.COLOR_PRIMARY)
            .setText(biometricPopUp!.butAction)
            .build()
        
        //UIApplication.shared.statusBarView?.backgroundColor = UIParameters.COLOR_BLACK_0
        
        
        iviImage.image = UIImage(named:  biometricPopUp!.image)
        
        /*switch self.biometricPopUp!.resultEnum {
        case .SUCCESS:
            iviImage.image = UIImage(named:  biometricPopUp!.image)
        case .ERROR:
            
            iviImage.tintColorUIImageView(nameImage: biometricPopUp!.image, color: UIParameters.COLOR_ERROR)
            //iviImage.setColorImage(color: UIParameters.COLOR_ERROR, nameImage: biometricPopUp!.image)
        }*/
        
    }
    
    func setup(){
      
    
    }
    // MARK: - Method
    
    
    
  
    
    // MARK: - Action UIView
    
    @IBAction func doneClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        switch self.biometricPopUp!.resultEnum {
        case .SUCCESS:
            self.delegatePopUp?.onPopUpSuccess()
        case .ERROR:
            
            self.delegatePopUp?.onPopUpError()
        }
        
        
    }
    
    
    
}

