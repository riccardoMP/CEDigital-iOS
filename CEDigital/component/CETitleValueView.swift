//
//  CETitleValueView.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/30/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//



import UIKit

@IBDesignable
class CETitleValueView: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
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
    
    public func initializeUI(title:String,value:String){
        
        
        lblTitle = LabelFluentBuilder.init(label: lblTitle)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText(title)
            .setTextSize(7, UIParameters.TTF_REGULAR)
            .build()
        
        lblValue = LabelFluentBuilder.init(label: lblValue)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText(value)
            .setTextSize(10, UIParameters.TTF_BOLD)
            .setDynamicFont()
            .build()
        
        
        
        
    }
    
    
    
    
}
