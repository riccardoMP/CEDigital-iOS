//
//  DisclaimerView.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 17/01/22.
//  Copyright © 2022 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

@IBDesignable
class DisclaimerView: UIView {
    @IBOutlet weak var iviIcon: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.contentView = view
        
        
        
        
    }
  
    
    func initializeUI( arrayDisclaimer : [String]){
        
        arrayDisclaimer.forEach {
            
            var characterLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.numberOfLines = 0
                return label
            }()
            
            characterLabel = LabelFluentBuilder.init(label: characterLabel)
                .setTextColor(UIParameters.COLOR_WHITE)
                .setText("• \($0)")
                .setTextSize(9, UIParameters.TTF_REGULAR)
                .setDynamicFont()
                .build()
            
            stackView.addArrangedSubview(characterLabel)
            
        }
    }
    
    
}

