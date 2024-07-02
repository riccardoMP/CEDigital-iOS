//
//  CheckBoxView.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/19/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//


import UIKit

class CheckBoxView: UIButton {
    // Images
    let checkedImage = UIImage(named: "ic_checkbox")! as UIImage
    let uncheckedImage = UIImage(named: "ic_checkbox_outline")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
       
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
