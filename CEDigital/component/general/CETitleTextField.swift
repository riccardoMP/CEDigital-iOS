//
//  CETitleTextField.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 9/12/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import UIKit

class CETitleTextField: UIView, UITextFieldDelegate {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtValue: CETextField!
    
    
    
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
        
        self.txtValue.delegate = self
        self.txtValue.addDoneOnKeyboardWithTarget(self, action: #selector(doneButtonClicked))
        
    }
    
    var maxLenght : Int = 0
    
    
    func setValue( value : String = ""){
        txtValue.text = value
    }
    
    func getValue() -> String{
        return txtValue.text ?? ""
    }
    
    func isEmpty() -> Bool{
        return txtValue.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isExpresionValid(expression: String) -> Bool{
        return txtValue.text!.isExpresionValid(expression: expression)
    }
    
    
    // MARK: - Setup
    public func initializeUI( title:String, placeholder: String, keyboardType: UIKeyboardType, maxLenght : Int = 0){
        
        
        lblTitle = LabelFluentBuilder.init(label: lblTitle)
            .setTextColor(UIParameters.COLOR_GRAY_ONBOARDING)
            .setText(title)
            .setTextSize(18, UIParameters.TTF_BOLD)
            .build()
        
        //AppUtils.changeUILabelStyle(label: self.lblTitle, lblText: title, color: UIParameters.COLOR_GRAY_BOLD_LIGHT, size: UIParameters.SIZE_APP_TEXT_14, typeFont: UIParameters.TTF_REGULAR)
        
        self.txtValue.changeUI(textPlaceHolder: placeholder, colorPlaceHolder: UIParameters.COLOR_GRAY_PASS, colorBackground: UIParameters.COLOR_WHITE, size: 14, typeFont: UIParameters.TTF_REGULAR, colorBorder: UIParameters.COLOR_GRAY_PASS)
        
        self.txtValue.placeholder = placeholder
        self.txtValue.keyboardType = keyboardType
        self.txtValue.returnKeyType = .done
        
        self.maxLenght = maxLenght
        
   
    }
    
    @objc func doneButtonClicked(_ sender: Any) {
        txtValue.resignFirstResponder()
        self.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text!.count + string.count - range.length
        
        if(maxLenght == 0){
            return true
        }else{
            return newLength <= maxLenght
        }
        
        
    }
}

