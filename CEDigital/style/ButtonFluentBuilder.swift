//
//  ButtonFluentBuilder.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class ButtonFluentBuilder {
    private let button: UIButton
    
    init(button: UIButton) {
        self.button = button
        self.button.layer.cornerRadius = 10 * AppUtils.getSizeFactor()
        self.button.contentEdgeInsets = UIEdgeInsets(top: 10 * AppUtils.getSizeFactor(), left: 10 * AppUtils.getSizeFactor(), bottom: 10 * AppUtils.getSizeFactor(), right: 10 * AppUtils.getSizeFactor())
        self.button.titleLabel?.font = UIFont.init(name: UIParameters.TTF_BOLD, size: 17 * AppUtils.getSizeFactor())
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setBackground(_ color:UIColor) -> Self {
        self.button.backgroundColor = color
        
        
        
        return self
    }
    
    func setTextColor(_ color:UIColor) -> Self {
        self.button.tintColor  = color
        
        return self
    }
    
    func setCornerRadius(_ radius: CGFloat) -> Self {
        self.button.layer.cornerRadius = radius * AppUtils.getSizeFactor()
        
        return self
    }
    
    func setText(_ text: String) -> Self {
        self.button.setTitle(text, for: .normal)
        
        return self
    }
    func setTextSize(_ size:CGFloat, _ typeFont:String = UIParameters.TTF_BOLD) -> Self {
           
           self.button.titleLabel?.font = UIFont.init(name: typeFont, size: size * AppUtils.getSizeFactor())
           
           return self
    }
    
    
    
   
    
    func setBorderColor(_ color:UIColor) -> Self {
        button.layer.borderColor = color.cgColor
        
        return self
    }
    
    func build() -> UIButton {
       //do something else
       return self.button
    }
    

}
