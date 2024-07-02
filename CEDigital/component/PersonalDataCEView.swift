//
//  PersonalDataCEView.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/10/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//



import UIKit

class PersonalDataCEView: UIView, UITextFieldDelegate {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    
    
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
        
        lblDescription.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.937254902, blue: 0.9490196078, alpha: 1)
        
        lblDescription.layer.cornerRadius = 8.0
        lblDescription.layer.masksToBounds = true
        lblDescription.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        lblDescription.layer.borderWidth = 0.5
        
        addSubview(view)
        self.contentView = view
        
        
        
    }
    
    
    
    public func initializeUI(title:String,value:String){
        
        
        lblTitle = LabelFluentBuilder.init(label: lblTitle)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText(title)
            .setTextSize(13, UIParameters.TTF_BOLD)
            .build()
        
        
        
        lblDescription = LabelFluentBuilder.init(label: lblDescription)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText(value)
            .setTextSize(12, UIParameters.TTF_REGULAR)
            .build()
        
        
        lblDescription.setMargins()
        
        
        
        
    }
    
}
