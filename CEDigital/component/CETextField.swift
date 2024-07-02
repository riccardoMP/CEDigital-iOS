//
//  CETextField.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/16/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import Foundation
import UIKit

class CETextField: UITextField {
    
    var padding:CGFloat = 4.0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: padding)
    }
    
    func changeUI(textPlaceHolder:String, colorPlaceHolder:UIColor, colorBackground: UIColor,  size:CGFloat, typeFont:String, colorBorder : UIColor = UIParameters.COLOR_WHITE){
        
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: colorPlaceHolder,
            NSAttributedString.Key.font : UIFont(name: typeFont, size: size)! // Note the !
        ]
        
        self.attributedPlaceholder = NSAttributedString(string: textPlaceHolder, attributes:attributes)
        self.backgroundColor = colorBackground
        
        self.textColor = UIParameters.COLOR_GRAY_ARROW
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.layer.borderColor = colorBorder.cgColor
        self.layer.borderWidth = 1
        

        
    }
}
