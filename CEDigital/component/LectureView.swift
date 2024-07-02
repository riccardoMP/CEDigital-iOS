//
//  LectureView.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/19/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//



import UIKit

class LectureView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var vIcon: UIView!
    @IBOutlet weak var iviIcon: UIImageView!
    
    
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
        
        contentView.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        
        contentView.layer.cornerRadius = 8.0
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        contentView.layer.borderWidth = 0.5
        
        addSubview(view)
        self.contentView = view
        
        AppUtils.enableUIViewAsButton(view: vIcon, selector: #selector(doActionImage), vc: self)
        
        
    }
    
    
    public func setDescription(value: String){
        lblDescription.text = value
    }
    
    public func initializeUI(title:String, description:String, image: String = ""){
        
        
        lblTitle = LabelFluentBuilder.init(label: lblTitle)
            .setTextColor(UIParameters.COLOR_PRIMARY)
            .setText(title)
            .setTextSize(11, UIParameters.TTF_REGULAR)
            .build()
        
        
        
        lblDescription = LabelFluentBuilder.init(label: lblDescription)
            .setTextColor(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1))
            .setText(description)
            .setTextSize(13, UIParameters.TTF_REGULAR)
            .build()
        
        
        if(image.isEmpty){
            iviIcon.isHidden = true
            vIcon.isHidden = true
        }else{
            vIcon.isHidden = false
            
            iviIcon.isHidden = false
            iviIcon.setColorImage(color: UIParameters.COLOR_DISCLAIMER, nameImage: image)
        }
        
        lblDescription.lineBreakMode = .byClipping
        lblDescription.adjustsFontSizeToFitWidth = true
        lblDescription.minimumScaleFactor = 0.5
        
        
        
    }
    
    
    @IBAction func doActionImage(_ sender: Any) {
        NotificationCenter.default.post(name: .actionImage, object: nil, userInfo: nil)
    }
}
