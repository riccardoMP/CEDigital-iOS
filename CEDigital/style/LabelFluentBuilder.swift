//
//  LabelFluentBuilder.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/15/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class LabelFluentBuilder {
    private let label: UILabel
    

    init(label: UILabel) {
        self.label = label
        
    }
    
    func setBackground(_ color:UIColor) -> Self {
        self.label.backgroundColor = color
        
        
        
        return self
    }
    
    func setTextColor(_ color:UIColor) -> Self {
        self.label.textColor  = color
        
        return self
    }
    

    func setText(_ text: String) -> Self {
        self.label.text = text
        
        return self
    }
    
    func setTextSize(_ size:CGFloat, _ typeFont:String) -> Self {
        self.label.font = UIFont(name: typeFont, size: size * AppUtils.getSizeFactor())
        
        return self
    }

    func setDynamicFont() -> Self {
        self.label.lineBreakMode = .byClipping
        self.label.adjustsFontSizeToFitWidth = true
        self.label.minimumScaleFactor = 0.5
        
        return self
    }
    
    func setBoldLikeWhatsapp() -> Self {
        let boldFont = UIFont(name: UIParameters.TTF_BOLD, size: self.label.font.pointSize)
        
        self.label.attributedText  = NSMutableAttributedString().boldAsteriskLikeWhatsapp(resultString: self.label.text!, originFont: self.label.font, boldFont: boldFont!)
        
        
        return self
    }
    
    
    
    func build() -> UILabel {
       //do something else
       return self.label
    }
    

}
