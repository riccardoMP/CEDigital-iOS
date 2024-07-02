//
//  AppUtils.swift
//  CEDigital
//
//  Created by Riccardo Mija Padilla on 8/9/20.
//  Copyright © 2020 Riccardo Mija Padilla. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import UIDeviceComplete

public class AppUtils{
    
    //func encodeObject<T>(_ type: T.Type) -> String{
    static func encodeObject<T:Codable>(_ type: T) -> Data{
        
        if let encoded = try? JSONEncoder().encode(type) {
            return encoded
        }else{
            return Data()
        }
    }
    
    // MARK: - Misc
    static func getURLEncoded(url:String) -> URL{
        
        //Encode because some URL return with characters that the URL object instance in nil
        let urlEncoded:String = (url.isEmpty) ? Constants.MIGRACIONES_WEB :  url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        
        return URL(string: urlEncoded)!
        
        
    }
    
    static func barButtonAboutVacation() -> UIBarButtonItem{
        let btnProfile = UIButton(frame: CGRect(x: 00, y: 0, width: 40, height: 20))
        btnProfile.setTitle("", for: .normal)
        btnProfile.backgroundColor = UIColor.clear
        btnProfile.layer.cornerRadius = 4.0
        btnProfile.layer.masksToBounds = true
        
        
        var imageProfile = UIImage(named: "ic_about_vacation")
        imageProfile = imageProfile?.withRenderingMode(UIImage.RenderingMode.automatic)
        btnProfile.setImage(imageProfile, for: .normal)
        
        let item = UIBarButtonItem(customView: btnProfile)
        
        return item
    }
    
    static func barButtonSearch() -> UIBarButtonItem{
        let btnProfile = UIButton(frame: CGRect(x: 00, y: 0, width: 40, height: 20))
        btnProfile.setTitle("", for: .normal)
        btnProfile.backgroundColor = UIColor.clear
        btnProfile.layer.cornerRadius = 4.0
        btnProfile.layer.masksToBounds = true
        
        
        var imageProfile = UIImage(named: "ic_filter")
        imageProfile = imageProfile?.withRenderingMode(UIImage.RenderingMode.automatic)
        btnProfile.setImage(imageProfile, for: .normal)
        
        let item = UIBarButtonItem(customView: btnProfile)
        
        return item
    }
    
    
    
    static func showMsgAlert(title:String, message:String, dismissAnimated:Bool, invokingVC:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "option_accept".localized, style: UIAlertAction.Style.default)
        {
            (action: UIAlertAction!) -> Void in
            if(dismissAnimated){
                alert.dismiss(animated: true, completion: nil)
            }else{
                alert.dismiss(animated: false, completion: nil)
            }
        })
        
        invokingVC.present(alert, animated: true, completion: nil)
    }
    
    static func changeUIButtonStyle(button:UIButton, bgColor:UIColor, tintColor:UIColor, text:String, size:CGFloat = 17, cornerRadius: CGFloat = 10, borderColor:UIColor = UIColor.clear){
        button.backgroundColor = bgColor
        button.tintColor = tintColor
        button.layer.cornerRadius = cornerRadius * getSizeFactor()
        button.contentEdgeInsets = UIEdgeInsets(top: 10 * getSizeFactor(), left: 10 * getSizeFactor(), bottom: 10 * getSizeFactor(), right: 10 * getSizeFactor())
        button.titleLabel?.font = UIFont.init(name: UIParameters.TTF_BOLD, size: size * getSizeFactor())
        button.setTitle(text, for: .normal)
        
        button.layer.borderWidth = 1
        button.layer.borderColor = borderColor.cgColor
        
    }
    
    static func changueStringByFont(text:String, size:CGFloat, color:UIColor, typeFont:String) -> NSMutableAttributedString{
        
        
        return NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont(name: typeFont, size: (size * getSizeFactor()))!, NSAttributedString.Key.foregroundColor: color])
        
        
    }
    
    
    
    static func changeUITextViewPlaceHolderStyle(textField:UITextField, color:UIColor, size: CGFloat, text: String){
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font : UIFont(name: UIParameters.TTF_REGULAR, size: size * getSizeFactor())! // Note the !
        ]
        
        textField.attributedPlaceholder = NSAttributedString(string: text, attributes:attributes)
        
    }
    
    
    
    
    static func changeUITextFieldBorder(textField:UITextField, color:UIColor){
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = color.cgColor
        
    }
    
    
    
    
    static func customPlaceHolderBulletPoint(textField:UITextField){
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIParameters.COLOR_PLACEHOLDER,
            NSAttributedString.Key.font : UIFont(name: UIParameters.TTF_REGULAR, size: 20 * getSizeFactor())! // Note the !
        ]
        
        textField.attributedPlaceholder = NSAttributedString(string: "•", attributes:attributes)
        
    }
    
    
    
    
    
    static func enableUIViewAsButton(view:UIView, selector:Selector, vc:AnyObject){
        let gesture = UITapGestureRecognizer(target: vc, action: selector)
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
    }
    
    static func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    
    static func generateArrayFromString(descrciption:String, separatedBy:String) -> [String]{
        
        return descrciption.components(separatedBy: separatedBy)
        
    }
    
    static func getSizeFactor() -> CGFloat{
        
        var sizeFactor : CGFloat
        let device = UIDevice().dc.deviceModel
        
        switch device {
        case .iPhone6, .iPhone6S, .iPhone7, .iPhone8, .iPhoneSE2, .iPhoneSE3:
            sizeFactor = UIParameters.SIZE_FACTOR_SMALL
        case .iPhoneSE, .iPhone5, .iPhone5S:
            sizeFactor = UIParameters.SIZE_FACTOR_TINY
            
        default:
            sizeFactor = UIParameters.SIZE_FACTOR_NORMAL
        }
        
        return sizeFactor
        
    }
    
    
    
    
    static func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    // MARK: - String Bold
    static func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    
    // MARK: - UIIMage
    static func tintColorUIImageView(view:UIImageView, nameImage:String, color:UIColor){
        
        
        let origImage = UIImage(named: nameImage);
        let tintedImage = origImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        view.image = tintedImage
        view.tintColor = color
    }
    
    
    
    
    
    // MARK: - Interaction App
    
    static func isCanOpenWhatsapp(phone:String) -> Bool{
        let urlWhats = "whatsapp://send?phone=51\(phone)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        return true
                    } else {
                        return true
                    }
                }
                else {
                    return false
                }
            }
        }
        return false
    }
    
    
    static func openWhatsapp(phone:String){
        let urlWhats = "whatsapp://send?phone=51\(phone)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    static func callPhone(phone:String){
        let numbersOnly = phone.replacingOccurrences(of: " ", with: "")
        
        if let url = URL(string: "tel://\(numbersOnly)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        else {
            print("Your device doesn't support this feature.")
        }
        
    }
    
    static func sendEmail(vc:UIViewController , email:String){
        let mailComposeViewController = configureMailComposer(vc: vc, email: email)
        if MFMailComposeViewController.canSendMail(){
            vc.present(mailComposeViewController, animated: true, completion: nil)
        } else if let emailUrl = createEmailUrl(to: email, subject: "", body: "") {
            UIApplication.shared.open(emailUrl)
        }
        
    }
    
    static func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        
        if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        }else if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
    
    static func configureMailComposer(vc:UIViewController , email:String) -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = (vc as! MFMailComposeViewControllerDelegate)
        mailComposeVC.setToRecipients([email])
        
        return mailComposeVC
    }
    
    
    static func openURL(url:String){
        print(url)
        let url = AppUtils.getURLEncoded(url: url)
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            //If you want handle the completion block than
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                print("Open url : \(success)")
            })
        }
    }
    
    
    // MARK: - Enum

    public enum EnumTypeCodeUser : String, Codable {
        case ACCESS                 = "A"
        case VERIFICATION           = "V"
        
        
    }
    
    public enum EnumSex : String, Codable {
        case MALE               = "M"
        case FEMALE             = "F"
        
        
    }
    
    public enum EnumStateDocument : Int {
        case STATE_FORWARD            = 1
        case STATE_BEHIND             = 2
        
    }
    
    
    public enum EnumStyleEditText  {
        case DEFAULT
        case DISABLE
        
        
    }
    
    // MARK: - Orientation
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
}
