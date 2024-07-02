//
//  CEFloatingPlaceholderTextField.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 1/10/21.
//  Copyright © 2021 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_FilledTextFieldsTheming
import UIKit


@IBDesignable
class CEFloatingPlaceholderTextField: UIView{
    
    //@objc var containerScheme: MDCContainerScheming = MDCContainerScheme()
    let containerScheme = MDCContainerScheme()
    
    private var _textInput  = MDCFilledTextField()
    //private var controller: MDCTextInputControllerFilled!
    private let textColor = UIColor(named: "textColor") // Dynamic dark & light color created in the assets folder
    private var placeHolderText = ""
    
    private var isSetupForPassword = false
    
    private var typeDocument: TypeEditText?
    private var enumStyle: AppUtils.EnumStyleEditText?
    
    var textInput: MDCFilledTextField{
        get{
            return _textInput
        }
        
    }
    
    @IBInspectable var setPlaceholder: String{
        get{
            return placeHolderText
        }
        set(str){
            placeHolderText = str
        }
    }
    
    override func layoutSubviews() {
        
        setupInputView()
        setupContoller()
        
        
        
        
    }
    
    func setKeyboardType(_ keyboardType:UIKeyboardType) {
        self.textInput.keyboardType  = keyboardType
        
        
    }
    
    
    private func setupInputView(){
        //MARK: Text Input Setup
        
        if let _ = self.viewWithTag(1){return}
        
        //textInput = MDCTextField()
        
        textInput.tag = 1
        textInput.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(textInput)
        
        textInput.placeholder = placeHolderText
        
        textInput.delegate = self
        
        textInput.textColor = textColor
        
        NSLayoutConstraint.activate([
            (textInput.topAnchor.constraint(equalTo: self.topAnchor)),
            (textInput.bottomAnchor.constraint(equalTo: self.bottomAnchor)),
            (textInput.leadingAnchor.constraint(equalTo: self.leadingAnchor)),
            (textInput.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        ])
    }
    
    private func setupContoller(){
        // MARK: Text Input Controller Setup
        
        /*controller = MDCTextInputControllerFilled(textInput: textInput)
         
         controller.isFloatingEnabled = true
         
         switch enumStyle {
         case .DISABLE:
         controller.activeColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1)
         controller.normalColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1)
         controller.textInput?.textColor = .black
         controller.inlinePlaceholderColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1)
         controller.floatingPlaceholderActiveColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1)
         controller.floatingPlaceholderNormalColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1)
         default:
         controller.activeColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1)
         controller.normalColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1)
         controller.textInput?.textColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
         controller.inlinePlaceholderColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1)
         controller.floatingPlaceholderActiveColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1)
         controller.floatingPlaceholderNormalColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alpha: 1)
         
         }*/
        
        
        //containerScheme.colorScheme.primaryColor = #colorLiteral(red: 0, green: 0.2823529412, blue: 0.6039215686, alph: 1)
        
        containerScheme.colorScheme.primaryColor = UIParameters.COLOR_PRIMARY
        containerScheme.colorScheme.secondaryColor = UIParameters.COLOR_PURPLE_COMBO
        
        //containerScheme.colorScheme.backgroundColor = UIParameters.COLOR_PURPLE_COMBO
        //containerScheme.colorScheme.primaryColorVariant = UIParameters.COLOR_ORANGE
        //containerScheme.colorScheme.secondaryColor = UIParameters.COLOR_PINK
        containerScheme.colorScheme.errorColor = UIParameters.COLOR_RED_DEFFEATED
        
        
        textInput.applyTheme(withScheme: containerScheme)
        textInput.setFilledBackgroundColor(UIParameters.COLOR_GRAY_TEXTFLEID, for: .editing)
        textInput.setFilledBackgroundColor(UIParameters.COLOR_GRAY_TEXTFLEID, for: .normal)
        textInput.setFilledBackgroundColor(UIParameters.COLOR_GRAY_TEXTFLEID, for: .disabled)
        
        textInput.setUnderlineColor(UIParameters.COLOR_PRIMARY, for: .normal)
        
        guard typeDocument != nil else {
            return
        }
        
        textInput.keyboardType  = UIKeyboardType(rawValue: typeDocument!.typeKeyboard)!
        textInput.label.text = typeDocument?.hint
        textInput.placeholder = ""
        
        
        if(isSetupForPassword){
            //Setup Password
            let imgOpenEye = UIImage(named: "ic_eye")?.imageWithColor(color: UIParameters.COLOR_PRIMARY_DARK)
            let imgCloseEye = UIImage(named: "ic_eye_close")?.imageWithColor(color: UIParameters.COLOR_RED_DEFFEATED)
            
            
            let passwordButton = UIButton(type: .custom)
            passwordButton.frame = CGRect(x: CGFloat(0), y: CGFloat(0),
                                          width: CGFloat(45), height: CGFloat(self.textInput.frame.height))
            passwordButton.setImage(imgOpenEye, for: .normal)
            passwordButton.setImage(imgCloseEye, for: .selected)
            passwordButton.addTarget(self, action: #selector(passViewTap), for: .touchUpInside)
            
            textInput.trailingView = passwordButton
            textInput.isSecureTextEntry = true
            textInput.trailingViewMode = .always
            
            textInput.sizeToFit()
            
            
        }
        
        //self.textInput.placeholder = typeDocument?.hint
        //controller.setErrorText(nil, errorAccessibilityValue: nil)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    
    func setError(_ message: String) {
        if(message.isEmpty){
            
            self.textInput.leadingAssistiveLabel.textColor = .blue
            self.textInput.leadingAssistiveLabel.text = nil
            self.textInput.leadingViewMode = .always
            self.textInput.leadingAssistiveLabel.tintColor = .red
            
            
        }else{
            
            self.textInput.leadingAssistiveLabel.textColor = UIParameters.COLOR_RED_DEFFEATED
            self.textInput.leadingAssistiveLabel.text = message
            self.textInput.leadingViewMode = .always
        }
        
        
    }
    
    
    func setupForPassword(_ typeDocument: TypeEditText, _ style : AppUtils.EnumStyleEditText = .DEFAULT) {
        
        
        self.isSetupForPassword = true
        
        self.setup(typeDocument, style)
        
        
        
    }
    
    func setup(_ typeDocument: TypeEditText, _ style : AppUtils.EnumStyleEditText = .DEFAULT) {
        self.typeDocument = typeDocument
        self.enumStyle = style
        
        
        self.setNeedsLayout()
        
        
    }
    
    @objc func passViewTap(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        textInput.isSecureTextEntry = !sender.isSelected
        
    }
    
}

extension CEFloatingPlaceholderTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text!.count + string.count - range.length
        
        return newLength <= self.typeDocument!.length
        
        
    }
    
}

