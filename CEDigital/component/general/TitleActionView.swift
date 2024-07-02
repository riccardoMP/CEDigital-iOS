//
//  TitleActionView.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/30/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class TitleActionView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var iviImage: UIImageView!
    
    
    
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
    
    
    // MARK: - Setup
    public func initializeUI(title : String){
        
        self.iviImage.setColorImage(color: #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1), nameImage: "ic_arrow_right")
        
        lblTitle = LabelFluentBuilder.init(label: lblTitle)
            .setTextColor(#colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1))
            .setText(title)
            .setTextSize(15, UIParameters.TTF_BOLD)
            .build()
        
        
        
    }
    
    
}
